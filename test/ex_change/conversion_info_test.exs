defmodule ExChange.ConversionInfoTest do
  use ExUnit.Case
  alias ExChange.ConversionInfo

  describe "from_api/1" do
    test "returns ConversionInfo" do
      api_params = %{
        "conversion_result" => 1234.56,
        "time_last_update_unix" => 1_637_452_802,
        "target_code" => "BRL"
      }

      assert %ConversionInfo{
               amount: 1234.56,
               currency: "BRL",
               updated_at: ~U[2021-11-21 00:00:02Z]
             } = ConversionInfo.from_api(api_params)
    end
  end
end
