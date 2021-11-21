defmodule ExChangeWeb.FallbackController do
  use ExChangeWeb, :controller

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExChangeWeb.ErrorView)
    |> render("error.json", errors: reason)
  end
end
