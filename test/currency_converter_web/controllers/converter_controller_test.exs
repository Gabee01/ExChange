defmodule CurrencyConverterWeb.ConverterControllerTest do
  use CurrencyConverterWeb.ConnCase
  import Mock

  test "GET / when conversion is successful", %{conn: conn} do
    with_mock CurrencyConverter, convert: fn _params -> {:ok, 10} end do
      conn = get(conn, "/10/EUR/USD")
      assert json_response(conn, 200) == %{"converted_value" => 10}
      assert_called(CurrencyConverter.convert(:_))
    end
  end

  test "GET / when conversion fails", %{conn: conn} do
    with_mock CurrencyConverter, convert: fn _params -> {:error, ["some reason"]} end do
      conn = get(conn, "/10/EUR/USD")
      assert json_response(conn, 422) == %{"errors" => ["some reason"]}
      assert_called(CurrencyConverter.convert(:_))
    end
  end
end
