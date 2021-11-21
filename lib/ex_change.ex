defmodule ExChange do
  @moduledoc """
  ExChange is responsible for calling the conversion api and compute the converted amount
  """
  alias ExChange.ConversionInfo

  @doc """
  Calls the external api to get current conversion between the given currencies
  and converts the amount requested.

  ## Examples

    iex> ExChange.convert(%{"current" => "USD", "target" => "EUR", "amount" => "100"})
    {:ok, %ConversionInfo{
        amount: 1234.56,
        currency: "BRL",
        updated_at: ~U[2021-11-21 00:00:02Z]
      }
    }
  """
  @spec convert(map()) :: {:ok, ConversionInfo.t()} | {:error, any()}
  def convert(%{} = params) do
    conversion_path = build_conversion_path(params)

    case Tesla.get(conversion_client(), conversion_path) do
      {:ok, %Tesla.Env{status: 200, body: %{"result" => "success"} = conversion_response}} ->
        {:ok, ConversionInfo.from_api(conversion_response)}

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
         "amount" => amount
       }) do
    "/#{api_key()}/pair/#{current_currency}/#{target_currency}/#{amount}"
  end

  defp api_key, do: Application.get_env(:ex_change, :conversion_api)[:api_key]
  defp base_url, do: Application.get_env(:ex_change, :conversion_api)[:url]
end
