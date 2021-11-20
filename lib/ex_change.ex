defmodule ExChange do
  # @moduledoc """
  # ExChange is responsible for managing calls to external services related to currency convertion
  # """

  # @doc """
  #   ExChange.convert(%{"value" => 500000, "current" => "USD", "target" => "BRL"})
  # """
  @spec convert(map()) :: {:ok, float()} | {:error, map()}
  def convert(%{} = params) do
    with {value, ""} <- Float.parse(params["value"]),
         {:ok, conversion_rate} <- get_conversion_rate(params) do
      {:ok, conversion_rate * value}
    end
  end

  defp get_conversion_rate(%{"current" => current_currency, "target" => target_currency}) do
    client = conversor_client()
    convert_pair_path = convert_pair_path(current_currency, target_currency)

    case Tesla.get(client, convert_pair_path) do
      {:ok, %Tesla.Env{status: 200, body: %{"result" => "success"} = conversion_response}} ->
        {:ok, conversion_response["conversion_rate"]}

      {:ok, %Tesla.Env{body: response}} ->
        {:error, response}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp conversor_client do
    middleware = [
      {Tesla.Middleware.BaseUrl, base_url()},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end

  defp convert_pair_path(current_currency, target_currency) do
    "/#{api_key()}/pair/#{current_currency}/#{target_currency}"
  end

  defp api_key, do: Application.get_env(:ex_change, :conversion_api)[:api_key]
  defp base_url, do: Application.get_env(:ex_change, :conversion_api)[:url]
end