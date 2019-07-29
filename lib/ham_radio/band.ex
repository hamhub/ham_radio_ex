defmodule HamRadio.Band do
  @moduledoc """
  Represents an amateur radio band.

  All frequencies are represented in Hz.

  See `HamRadio.Bands` for band enumeration and access.
  """

  defstruct [:name, :range]

  @type t :: %__MODULE__{
          name: String.t(),
          range: Range.t()
        }
end
