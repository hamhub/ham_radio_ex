defmodule HamRadio.GridTest do
  use ExUnit.Case
  doctest HamRadio.Grid

  alias HamRadio.Grid

  # Source of truth: http://www.levinecentral.com/ham/grid_square.php?Grid=FN21wa

  test "converting coords to grids" do
    # ZIP 55555
    assert {:ok, "FN03"} = Grid.encode({43.7278221, -79.4793724})

    # ZIP 90210
    assert {:ok, "DM04tc"} = Grid.encode({34.103, -118.41}, 6)

    # Invalid examples
    assert :error = Grid.encode(:derp)
    assert :error = Grid.encode({91, 0})
    assert :error = Grid.encode({0, 181})
  end

  test "convert grids to coords" do
    assert {:ok, {38.5, -83.0}} = Grid.decode("EM88")
    assert {:ok, {38.020833333333336, -83.95833333333333}} = Grid.decode("EM88aa")

    assert :error = Grid.decode("WW1X")
  end
end
