defmodule CurrencyConverterWeb.ConverterController do
  use CurrencyConverterWeb, :controller
  action_fallback(CurrencyConverterWeb.FallbackController)

  def index(conn, params) do
    case CurrencyConverter.convert(params) do
      {:ok, converted_value} -> json(conn, %{converted_value: converted_value})
      {:error, reason} -> {:error, reason}
    end
  end
end
