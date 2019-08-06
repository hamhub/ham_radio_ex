defmodule HamRadio.BandsTest do
  use ExUnit.Case

  alias HamRadio.Bands

  test "listing bands" do
    assert Bands.list() != []

    # Check they're sorted correctly
    freqs = for band <- Bands.list(), do: band.range.first
    assert freqs == Enum.sort(freqs)
  end

  test "finding a band by frequency" do
    assert %{name: "20m"} = Bands.at(14_313_000)
    assert nil == Bands.at(14_360_000)
  end

  test "finding a band by name" do
    assert %{name: "40m"} = Bands.find("40m")
    assert nil == Bands.find("foobar")
  end

  test "finding band by frequency when argument is a float" do
    freq = 3.570124 * 1_000_000
    assert %{name: "80m"} = Bands.at(freq)
  end
end
