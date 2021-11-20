defmodule ExChangeTest do
  use ExUnit.Case
  import Mock

  describe "convert/2" do
    @url "https://v6.exchangerate-api.com/v6/"
    @api_key "some_special_key"
    setup [:setup_environment]

    test "converts EUR to USD" do
      params = %{"value" => "10", "current" => "EUR", "target" => "USD"}
      expected_url = "/#{@api_key}/pair/EUR/USD/10"

      expected_body = %{
        "result" => "success",
        "conversion_result" => 11.5280,
        "time_last_update_utc" => "Sat, 20 Nov 2021 00:00:01 +0000"
      }

      response = %Tesla.Env{body: expected_body, status: 200}

      with_mock Tesla, [:passthrough],
        get: fn %Tesla.Client{}, ^expected_url -> {:ok, response} end do
        expected_conversion_info = %{
          converted_value: 11.5280,
          converted_at: "Sat, 20 Nov 2021 00:00:01 +0000"
        }

        assert ExChange.convert(params) == {:ok, expected_conversion_info}

        assert_called(Tesla.get(:_, :_))
      end
    end

    test "returns error when conversion fails" do
      params = %{"value" => "10", "current" => "AEUR", "target" => "USDA"}
      failure_body = %{"result" => "error", "error-type" => "malformed-request"}
      response = %Tesla.Env{body: failure_body, status: 200}

      with_mock Tesla, [:passthrough], get: fn %Tesla.Client{}, _ -> {:ok, response} end do
        assert ExChange.convert(params) == {:error, "malformed-request"}
        assert_called(Tesla.get(:_, :_))
      end
    end

    test "returns error when request fails" do
      params = %{"value" => "10", "current" => "EUR", "target" => "USD"}

      with_mock Tesla, [:passthrough], get: fn %Tesla.Client{}, _ -> {:error, {:no_schema}} end do
        assert ExChange.convert(params) == {:error, {:no_schema}}
        assert_called(Tesla.get(:_, :_))
      end
    end

    test "returns error when can't complete the conversion" do
      params = %{"value" => "10", "current" => "EUR", "target" => "USD"}

      with_mock Tesla, [:passthrough], get: fn %Tesla.Client{}, _ -> {:error, :timeout} end do
        assert ExChange.convert(params) == {:error, :timeout}
        assert_called(Tesla.get(:_, :_))
      end
    end

    defp setup_environment(_context) do
      configuration = %{url: @url, api_key: @api_key}
      Application.put_env(:ex_change, :conversion_api, configuration)
    end
  end
end
