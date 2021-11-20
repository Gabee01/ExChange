defmodule CurrencyConverterWeb.ConverterController do
  use CurrencyConverterWeb, :controller
  action_fallback(CurrencyConverterWeb.FallbackController)

  def index(conn, params) do
    with {:ok, converted_value} <- CurrencyConverter.convert(params) do
      json(conn, %{converted_value: converted_value})
    end
  end
end
