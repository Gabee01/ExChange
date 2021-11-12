defmodule CurrencyConverterWeb.ConverterController do
  use CurrencyConverterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
