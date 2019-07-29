defmodule HamRadio.Bands do
  @moduledoc """
  Retrieves amateur radio bands.

  Band names and ranges have been defined directly from the
  [ADIF 3.1.0 specification](http://adif.org/310/ADIF_310.htm#Band_Enumeration).
  """

  alias HamRadio.Band

  @bands [
    %Band{
      name: "2190m",
      range: 135_700..137_800
    },
    %Band{
      name: "630m",
      range: 472_000..479_000
    },
    %Band{
      name: "560m",
      range: 501_000..504_000
    },
    %Band{
      name: "160m",
      range: 1_800_000..2_000_000
    },
    %Band{
      name: "80m",
      range: 3_500_000..4_000_000
    },
    %Band{
      name: "60m",
      range: 5_060_000..5_450_000
    },
    %Band{
      name: "40m",
      range: 7_000_000..7_300_000
    },
    %Band{
      name: "30m",
      range: 10_000_000..10_150_000
    },
    %Band{
      name: "20m",
      range: 14_000_000..14_350_000
    },
    %Band{
      name: "17m",
      range: 18_068_000..18_168_000
    },
    %Band{
      name: "15m",
      range: 21_000_000..21_450_000
    },
    %Band{
      name: "12m",
      range: 24_890_000..24_990_000
    },
    %Band{
      name: "10m",
      range: 28_000_000..29_700_000
    },
    %Band{
      name: "6m",
      range: 50_000_000..54_000_000
    },
    %Band{
      name: "4m",
      range: 70_000_000..71_000_000
    },
    %Band{
      name: "2m",
      range: 144_000_000..148_000_000
    },
    %Band{
      name: "1.25m",
      range: 222_000_000..225_000_000
    },
    %Band{
      name: "70cm",
      range: 420_000_000..450_000_000
    },
    %Band{
      name: "33cm",
      range: 902_000_000..928_000_000
    },
    %Band{
      name: "23cm",
      range: 1_240_000_000..1_300_000_000
    },
    %Band{
      name: "13cm",
      range: 2_300_000_000..2_450_000_000
    },
    %Band{
      name: "9cm",
      range: 3_300_000_000..3_500_000_000
    },
    %Band{
      name: "6cm",
      range: 5_650_000_000..5_925_000_000
    },
    %Band{
      name: "3cm",
      range: 10_000_000_000..10_500_000_000
    },
    %Band{
      name: "1.25cm",
      range: 24_000_000_000..24_250_000_000
    },
    %Band{
      name: "6mm",
      range: 47_000_000_000..47_200_000_000
    },
    %Band{
      name: "4mm",
      range: 75_500_000_000..81_000_000_000
    },
    %Band{
      name: "2.5mm",
      range: 119_980_000_000..120_020_000_000
    },
    %Band{
      name: "2mm",
      range: 142_000_000_000..149_000_000_000
    },
    %Band{
      name: "1mm",
      range: 241_000_000_000..250_000_000_000
    }
  ]

  @doc """
  Returns a list of all known bands.

  Bands are sorted by increasing frequency.
  """
  @spec list :: [Band.t()]
  def list, do: @bands

  @doc """
  Returns the band at a particular frequency.

  Band edges are inclusive.

  Returns `nil` if no band is found.
  """
  @spec at(integer) :: Band.t() | nil
  def at(hz) do
    @bands |> Enum.find(fn band -> hz in band.range end)
  end

  @doc """
  Returns a band with a particular ADIF name.

  Returns `nil` if no band is found.
  """
  @spec find(String.t()) :: Band.t() | nil
  def find(name) do
    @bands |> Enum.find(fn band -> band.name == name end)
  end
end
