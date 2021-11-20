defmodule ExChangeWeb.FallbackController do
  use ExChangeWeb, :controller

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ExChangeWeb.ErrorView)
    |> render("error.json", errors: reason)
  end
end
