defmodule CurrencyConverter do
  @moduledoc """
  CurrencyConverter is responsible for managing calls to external services related to currency convertion
  """

  @spec convert(map()) :: {:ok, float()} | {:error, map()}
  def convert(%{"value" => value} = params) do
    with {:ok, conversion_rate} <- get_conversion_rate(params) do
      {:ok, conversion_rate * value}
    end
  end

  defp get_conversion_rate(%{"current" => current_currency, "target" => target_currency}) do
    url = build_url(current_currency, target_currency)

    case Tesla.get(url) do
      {:ok, %Tesla.Env{status: 200, body: %{"result" => "success"} = response}} ->
        {:ok, response["conversion_rate"]}

      {:ok, %Tesla.Env{body: response}} ->
        {:error, response}

      # {:error, %Tesla.env{body: response}} -> _?

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp build_url(current_currency, target_currency) do
    base_url = Application.get_env(:currency_converter, :conversion_api)[:url]
    api_key = Application.get_env(:currency_converter, :conversion_api)[:api_key]
    "#{base_url}/#{api_key}/pair/#{current_currency}/#{target_currency}"
  end
end
