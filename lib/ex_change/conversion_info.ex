defmodule ExChange.ConversionInfo do
  alias __MODULE__

  @enforce_keys ~w(amount currency updated_at)a
  defstruct ~w(amount currency updated_at)a

  @type t :: %ConversionInfo{
          amount: Decimal.t(),
          currency: String.t(),
          updated_at: DateTime.t()
        }

  def from_api(params) do
    %ConversionInfo{
      amount: params["conversion_result"],
      currency: params["target_code"],
      updated_at: DateTime.from_unix!(params["time_last_update_unix"])
    }
  end
end
