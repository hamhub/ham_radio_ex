defmodule HamRadio.Band do
  defstruct [:id, :name, :min, :max, :default_unit, :dxcc]
  alias __MODULE__

  def bands do
    [
      %Band{
        id: "2190m",
        name: "2190m",
        min: 136_000,
        max: 137_000,
        default_unit: "kHz",
        dxcc: false
      },
      %Band{
        id: "630m",
        name: "630m",
        min: 472_000,
        max: 479_000,
        default_unit: "kHz",
        dxcc: false
      },
      %Band{
        id: "560m",
        name: "560m",
        min: 501_000,
        max: 504_000,
        default_unit: "kHz",
        dxcc: false
      },
      %Band{
        id: "160m",
        name: "160m",
        min: 1_800_000,
        max: 2_000_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "80m",
        name: "80m",
        min: 3_500_000,
        max: 4_000_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "60m",
        name: "60m",
        min: 5_102_000,
        max: 5_406_500,
        default_unit: "kHz",
        dxcc: false
      },
      %Band{
        id: "40m",
        name: "40m",
        min: 7_000_000,
        max: 7_300_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "30m",
        name: "30m",
        min: 10_000_000,
        max: 10_150_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "20m",
        name: "20m",
        min: 14_000_000,
        max: 14_350_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "17m",
        name: "17m",
        min: 18_068_000,
        max: 18_168_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "15m",
        name: "15m",
        min: 21_000_000,
        max: 21_450_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "12m",
        name: "12m",
        min: 24_890_000,
        max: 24_990_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "10m",
        name: "10m",
        min: 28_000_000,
        max: 29_700_000,
        default_unit: "kHz",
        dxcc: true
      },
      %Band{
        id: "6m",
        name: "6m",
        min: 50_000_000,
        max: 54_000_000,
        default_unit: "MHz",
        dxcc: true
      },
      %Band{
        id: "4m",
        name: "4m",
        min: 70_000_000,
        max: 71_000_000,
        default_unit: "MHz",
        dxcc: false
      },
      %Band{
        id: "2m",
        name: "2m",
        min: 144_000_000,
        max: 148_000_000,
        default_unit: "MHz",
        dxcc: true
      },
      %Band{
        id: "1.25m",
        name: "1.25m",
        min: 222_000_000,
        max: 225_000_000,
        default_unit: "MHz",
        dxcc: false
      },
      %Band{
        id: "70cm",
        name: "70cm",
        min: 420_000_000,
        max: 450_000_000,
        default_unit: "MHz",
        dxcc: true
      },
      %Band{
        id: "33cm",
        name: "33cm",
        min: 902_000_000,
        max: 928_000_000,
        default_unit: "MHz",
        dxcc: false
      },
      %Band{
        id: "23cm",
        name: "23cm",
        min: 1_240_000_000,
        max: 1_300_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "13cm",
        name: "13cm",
        min: 2_300_000_000,
        max: 2_450_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "9cm",
        name: "9cm",
        min: 3_300_000_000,
        max: 3_500_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "6cm",
        name: "6cm",
        min: 5_650_000_000,
        max: 5_925_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "3cm",
        name: "3cm",
        min: 10_000_000_000,
        max: 10_500_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "1.25cm",
        name: "1.25cm",
        min: 24_000_000_000,
        max: 24_250_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "6mm",
        name: "6mm",
        min: 47_000_000_000,
        max: 47_200_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "4mm",
        name: "4mm",
        min: 75_500_000_000,
        max: 81_000_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "2.5mm",
        name: "2.5mm",
        min: 119_980_000_000,
        max: 120_020_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "2mm",
        name: "2mm",
        min: 142_000_000_000,
        max: 149_000_000_000,
        default_unit: "GHz",
        dxcc: false
      },
      %Band{
        id: "1mm",
        name: "1mm",
        min: 241_000_000_000,
        max: 250_000_000_000,
        default_unit: "GHz",
        dxcc: false
      }
    ]
  end

  def bands_map do
    bands() |> Enum.map(&{&1.id, &1}) |> Enum.into(%{})
  end

  def at(hz) do
    Enum.find(bands(), fn %Band{min: min, max: max} ->
      min <= hz && max >= hz
    end)
  end

  def find(id) do
    case Map.get(bands_map(), id) do
      nil -> {:error, :not_found}
      band -> {:ok, band}
    end
  end
end
