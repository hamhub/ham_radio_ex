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

    assert_raise ArgumentError, fn ->
      Grid.encode!({1234, 5678})
    end

    assert_raise ArgumentError, fn ->
      Grid.encode!({0, 0}, 7)
    end
  end

  test "convert grids to coords" do
    assert {:ok, {38.5, -83.0}} = Grid.decode("EM88")
    assert {:ok, {38.020833333333336, -83.95833333333333}} = Grid.decode("EM88aa")

    assert :error = Grid.decode("WW1X")

    assert {38.5, -83.0} = Grid.decode!("EM88")

    assert_raise ArgumentError, fn ->
      Grid.decode!("boom!")
    end
  end

  test "convert grids to rectangles" do
    assert {:ok, {{42.0, 43.0}, {-74.0, -72.0}}} == Grid.decode_bounds("FN32")

    assert {:ok,
            {{41.97083333333334, 42.07083333333333}, {-74.05833333333332, -73.85833333333333}}} ==
             Grid.decode_bounds("FN32aa")

    assert :error == Grid.decode_bounds("FN")

    assert {{42.0, 43.0}, {-74.0, -72.0}} = Grid.decode_bounds!("FN32")

    assert_raise ArgumentError, fn ->
      Grid.decode_bounds!("FN")
    end
  end
end
