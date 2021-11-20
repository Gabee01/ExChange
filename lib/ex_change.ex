defmodule ExChange do
  @moduledoc """
  ExChange is responsible for calling the conversion api and compute the converted value
  """

  @doc """
  Calls the external api to get current conversion between the given currencies
  and converts the amount requested.

  ## Examples

      iex> ExChange.convert(%{"current" => "USD", "target" => "EUR", "value" => "100"})
      {:ok, %{
        converted_value: 88.3200,
        converted_at: "Sat, 20 Nov 2021 00:00:01 +0000"
      }}
  """
  @spec convert(map()) :: {:ok, float()} | {:error, any()}
  def convert(%{} = params) do
    case Tesla.get(conversion_client(), build_conversion_path(params)) do
      {:ok, %Tesla.Env{status: 200, body: %{"result" => "success"} = conversion_response}} ->
        {:ok, build_conversion_info(conversion_response)}

      {:ok, %Tesla.Env{status: 400, body: %{"result" => "error"} = error_reponse}} ->
        {:error, error_reponse["error-type"]}

      {:ok, %Tesla.Env{}} ->
        {:error, "Invalid request"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp conversion_client do
    middleware = [{Tesla.Middleware.BaseUrl, base_url()}, Tesla.Middleware.JSON]
    Tesla.client(middleware)
  end

  defp build_conversion_path(%{
         "current" => current_currency,
         "target" => target_currency,
         "value" => amount
       }) do
    "/#{api_key()}/pair/#{current_currency}/#{target_currency}/#{amount}"
  end

  defp build_conversion_info(conversion_response) do
    %{
      converted_at: conversion_response["time_last_update_utc"],
      converted_value: conversion_response["conversion_result"]
    }
  end

  defp api_key, do: Application.get_env(:ex_change, :conversion_api)[:api_key]
  defp base_url, do: Application.get_env(:ex_change, :conversion_api)[:url]
end
