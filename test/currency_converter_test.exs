defmodule CurrencyConverterTest do
  use ExUnit.Case
  import Mock

  describe "convert/2" do
    @url "https://v6.exchangerate-api.com/"
    @api_key "some_special_key"
    setup [:setup_environment]

    test "converts EUR to USD" do
      params = %{"value" => 10, "current" => "EUR", "target" => "USD"}
      expected_url = "#{@url}/#{@api_key}/pair/EUR/USD"

      expected_body = %{
        "result" => "success",
        "time_last_update_unix" => 1_636_675_202,
        "time_last_update_utc" => "Fri, 12 Nov 2021 00:00:02 +0000",
        "time_next_update_unix" => 1_636_761_602,
        "time_next_update_utc" => "Sat, 13 Nov 2021 00:00:02 +0000",
        "base_code" => "EUR",
        "target_code" => "USD",
        "conversion_rate" => 1.1528
      }

      response = %Tesla.Env{body: expected_body, status: 200}

      with_mock Tesla, get: fn ^expected_url -> {:ok, response} end do
        assert CurrencyConverter.convert(params) == {:ok, 11.528}
      end
    end

    test "returns error when conversion fails" do
      params = %{"value" => 10, "current" => "EUR", "target" => "USDA"}
      failure_body = %{"result" => "error", "error-type" => "malformed-request"}
      response = %Tesla.Env{body: failure_body, status: 200}

      with_mock Tesla, get: fn _ -> {:ok, response} end do
        assert CurrencyConverter.convert(params) == {:error, failure_body}
      end
    end

    test "returns error when api fails" do
      params = %{"value" => 10, "current" => "EUR", "target" => "USD"}
      response = %Tesla.Env{body: "error", status: 500}

      with_mock Tesla, get: fn _ -> {:ok, response} end do
        assert CurrencyConverter.convert(params) == {:error, "error"}
      end
    end

    test "returns error when can't complete the conversion" do
      params = %{"value" => 10, "current" => "EUR", "target" => "USD"}

      with_mock Tesla, get: fn _ -> {:error, :timeout} end do
        assert CurrencyConverter.convert(params) == {:error, :timeout}
      end
    end

    defp setup_environment(_context) do
      configuration = %{url: @url, api_key: @api_key}
      Application.put_env(:currency_converter, :conversion_api, configuration)
    end
  end
end
