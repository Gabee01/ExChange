defmodule ExChangeWeb.ConverterControllerTest do
  use ExChangeWeb.ConnCase
  import Mock

  test "GET /api/convert when conversion is successful", %{conn: conn} do
    expected_conversion_info = %{
      converted_value: 11.5280,
      converted_at: "Sat, 20 Nov 2021 00:00:01 +0000"
    }

    with_mock ExChange, convert: fn _params -> {:ok, expected_conversion_info} end do
      conn = get(conn, "/api/convert/10/EUR/USD")

      assert json_response(conn, 200) == %{
               "conversion_info" => %{
                 "converted_value" => 11.5280,
                 "converted_at" => "Sat, 20 Nov 2021 00:00:01 +0000"
               }
             }

      assert_called(ExChange.convert(:_))
    end
  end

  test "GET /api/convert when conversion fails", %{conn: conn} do
    with_mock ExChange, convert: fn _params -> {:error, ["some reason"]} end do
      conn = get(conn, "/api/convert/10/EUR/USD")
      assert json_response(conn, 422) == %{"errors" => ["some reason"]}
      assert_called(ExChange.convert(:_))
    end
  end
end
