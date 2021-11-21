defmodule ExChange.ConversionInfo do
  @moduledoc """
  ConversionInfo holds the converted information
  """
  alias __MODULE__

  @enforce_keys ~w(amount currency updated_at)a
  defstruct ~w(amount currency updated_at)a

  @type t :: %ConversionInfo{
          amount: Decimal.t(),
          currency: String.t(),
          updated_at: DateTime.t()
        }

  @doc """
  Maps the response from the queried API to the ConversionInfo struct

  ## Examples

    iex(1)> ConversionInfo.from_api(%{
    ...(1)>         "conversion_result" => 1234.56,
    ...(1)>         "time_last_update_unix" => 1_637_452_802,
    ...(1)>         "target_code" => "BRL"
    ...(1)>       })
    %ExChange.ConversionInfo{
      amount: 1234.56,
      currency: "BRL",
      updated_at: ~U[2021-11-21 00:00:02Z]
    }
  """
  @spec from_api(map()) :: ConversionInfo.t()
  def from_api(params) do
    %ConversionInfo{
      amount: params["conversion_result"],
      currency: params["target_code"],
      updated_at: DateTime.from_unix!(params["time_last_update_unix"])
    }
  end
end
