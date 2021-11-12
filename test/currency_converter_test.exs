defmodule CurrencyConverterTest do
  use ExUnit.Case
  import Mock

  describe "convert/2" do
    @url "https://v6.exchangerate-api.com/v6/"
    @api_key "some_special_key"
    setup [:setup_environment]

    test "converts EUR to USD" do
      params = %{"value" => "10", "current" => "EUR", "target" => "USD"}

      expected_url = "/#{@api_key}/pair/EUR/USD"
      expected_body = %{"result" => "success", "conversion_rate" => 1.1528}
      response = %Tesla.Env{body: expected_body, status: 200}

      with_mock Tesla, [:passthrough],
        get: fn %Tesla.Client{}, ^expected_url -> {:ok, Jason.encode(response)} end do
        assert CurrencyConverter.convert(params) == {:ok, 11.528}
        assert_called(Tesla.get(:_, :_))
      end
    end

    test "returns error when conversion results on error" do
      params = %{"value" => "Ten", "current" => "AEUR", "target" => "USDA"}
      failure_body = %{"result" => "error", "error-type" => "malformed-request"}
      response = %Tesla.Env{body: failure_body, status: 200}

      with_mock Tesla, [:passthrough], get: fn %Tesla.Client{}, _ -> {:ok, response} end do
        assert CurrencyConverter.convert(params) == {:error, failure_body}
        assert_called(Tesla.get(:_, :_))
      end
    end

    test "returns error when request fails" do
      params = %{"value" => 10, "current" => "EUR", "target" => "USD"}
      response = %Tesla.Env{body: "error", status: 500}

      with_mock Tesla, [:passthrough], get: fn %Tesla.Client{}, _ -> {:ok, response} end do
        assert CurrencyConverter.convert(params) == {:error, "error"}
        assert_called(Tesla.get(:_, :_))
      end
    end

    test "returns error when can't complete the conversion" do
      params = %{"value" => 10, "current" => "EUR", "target" => "USD"}

      with_mock Tesla, [:passthrough], get: fn %Tesla.Client{}, _ -> {:error, :timeout} end do
        assert CurrencyConverter.convert(params) == {:error, :timeout}
        assert_called(Tesla.get(:_, :_))
      end
    end

    defp setup_environment(_context) do
      configuration = %{url: @url, api_key: @api_key}
      Application.put_env(:currency_converter, :conversion_api, configuration)
    end
  end
end
