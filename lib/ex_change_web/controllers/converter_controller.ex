defmodule ExChangeWeb.ConverterController do
  use ExChangeWeb, :controller
  action_fallback(ExChangeWeb.FallbackController)

  def index(conn, params) do
    with {:ok, converted_value} <- ExChange.convert(params) |> IO.inspect() do
      json(conn, %{converted_value: converted_value})
    end
  end
end
