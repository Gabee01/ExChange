defmodule ExChangeWeb.ConverterControllerTest do
  use ExChangeWeb.ConnCase
  import Mock
  alias ExChange.ConversionInfo

  test "GET /api/convert when conversion is successful", %{conn: conn} do
    path_params = %{"current" => "EUR", "target" => "USD", "value" => "10"}

    expected_conversion_info = %ConversionInfo{
      amount: 11.5280,
      currency: "USD",
      updated_at: ~U[2021-11-21 00:00:02Z]
    }

    with_mock ExChange, convert: fn ^path_params -> {:ok, expected_conversion_info} end do
      conn = get(conn, "/api/convert/10/EUR/USD")

      assert json_response(conn, 200) == %{
               "data" => %{
                 "amount" => 11.528,
                 "currency" => "USD",
                 "updated_at" => "2021-11-21T00:00:02Z"
               }
             }

      assert_called(ExChange.convert(:_))
    end
  end

  test "GET /api/convert when conversion fails", %{conn: conn} do
    path_params = %{"current" => "EUR", "target" => "USD", "value" => "10"}

    with_mock ExChange, convert: fn ^path_params -> {:error, ["some reason"]} end do
      conn = get(conn, "/api/convert/10/EUR/USD")
      assert json_response(conn, 422) == %{"errors" => ["some reason"]}
      assert_called(ExChange.convert(:_))
    end
  end
end
