defmodule ExChange do
  @moduledoc """
  ExChange is responsible for calling the conversion api and compute the converted value
  """

  @doc """
  Calls the external api to get current conversion between the given currencies
  and converts the amount requested.

  ## Examples

      iex> ExChange.convert(%{"value" => 1000, "current" => "USD", "target" => "EUR"})
      {:ok, ???}
  """
  @spec convert(map()) :: {:ok, Decimal.t()} | {:error, any()}
  def convert(%{} = params) do
    amount = Decimal.new(params["value"])

    case get_conversion_rate(params) do
      {:ok, conversion_rate} ->
        converted_amount = Decimal.mult(conversion_rate, amount)
        {:ok, converted_amount}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp get_conversion_rate(%{"current" => current_currency, "target" => target_currency}) do
    client = conversor_client()
    convert_pair_path = convert_pair_path(current_currency, target_currency)

    case Tesla.get(client, convert_pair_path) do
      {:ok, %Tesla.Env{status: 200, body: %{"result" => "success"} = conversion_response}} ->
        conversion_rate = Decimal.from_float(conversion_response["conversion_rate"])
        {:ok, conversion_rate}

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
