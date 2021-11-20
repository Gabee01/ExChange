defmodule CurrencyConverterWeb.FallbackController do
  use CurrencyConverterWeb, :controller

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(CurrencyConverterWeb.ErrorView)
    |> render("error.json", errors: reason)
  end
end
