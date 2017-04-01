defmodule HexTileTest do
  alias HexGrid.Hex, as: Hex

  use ExUnit.Case, async: true
  doctest Hex

  describe "Hex.new/3" do
    test "new returns hex with status" do
      assert {:ok, hex} = Hex.new(0, 1, -1)
      assert hex != nil
    end

    test "raises error on invalid hex" do
      assert {:error, message} = Hex.new(0, 1, 1)
      assert message == "Invalid coordinates in hex given, coordinate scalars q, r and s in %Hex{q:0, r:1, s:1} do not sum to 0"
    end
  end

  describe "Hex.new!/3" do
    test "init returns hex" do
      assert Hex.new!(0, 1, -1) != nil
    end

    test "raises error on invalid hex" do
      assert_raise ArgumentError, fn -> Hex.new!(1, 1, 1) end
    end
  end

  test "two tiles with same coordinates equal" do
    first = Hex.new!(0, 1, -1)
    second = Hex.new!(0, 1, -1)

    assert first == second
  end

  test "two tiles with different coordinates do not equal" do
    first = Hex.new!(0, 0, 0)
    second = Hex.new!(0, 1, -1)
    assert first != second
  end

  test "adding two hexes" do
    first = Hex.new!(0, 1, -1)
    second = Hex.new!(0, 2, -2)
    assert Hex.add(first, second) == Hex.new!(0, 3, -3)
  end

  test "subtracting two hexes" do
    first = Hex.new!(1, 2, -3)
    second = Hex.new!(2, 3, -5)
    assert Hex.sub(first, second) == Hex.new!(-1, -1, 2)
  end

  describe "neighbours" do
    setup do
      {:ok, origin_hex: Hex.new!(0, 0, 0),
            offset_hex: Hex.new!(1,-1, 0)}
    end

    test "produces correct neighbour counts for a distance", state do
      assert Hex.neighbourhood(state.origin_hex, 0) |> Enum.count == 1
      assert Hex.neighbourhood(state.origin_hex, 1) |> Enum.count == 7
      assert Hex.neighbourhood(state.origin_hex, 2) |> Enum.count == 19
      assert Hex.neighbourhood(state.origin_hex, 3) |> Enum.count == 37

      assert Hex.neighbourhood(state.offset_hex, 0) |> Enum.count == 1
      assert Hex.neighbourhood(state.offset_hex, 1) |> Enum.count == 7
      assert Hex.neighbourhood(state.offset_hex, 2) |> Enum.count == 19
      assert Hex.neighbourhood(state.offset_hex, 3) |> Enum.count == 37
    end

    test "produces correct neighbors for a distance", state do
      assert Hex.neighbourhood(state.origin_hex, 1) == [%HexGrid.Hex{q: -1, r: 0, s: 1},
                                                        %HexGrid.Hex{q: -1, r: 1, s: 0},
                                                        %HexGrid.Hex{q: 0, r: -1, s: 1},
                                                        %HexGrid.Hex{q: 0, r: 0, s: 0},
                                                        %HexGrid.Hex{q: 0, r: 1, s: -1},
                                                        %HexGrid.Hex{q: 1, r: -1, s: 0},
                                                        %HexGrid.Hex{q: 1, r: 0, s: -1}]

      assert Hex.neighbourhood(state.offset_hex, 1) == [%HexGrid.Hex{q: 0, r: -1, s: 1},
                                                        %HexGrid.Hex{q: 0, r: 0, s: 0},
                                                        %HexGrid.Hex{q: 1, r: -2, s: 1},
                                                        %HexGrid.Hex{q: 1, r: -1, s: 0},
                                                        %HexGrid.Hex{q: 1, r: 0, s: -1},
                                                        %HexGrid.Hex{q: 2, r: -2, s: 0},
                                                        %HexGrid.Hex{q: 2, r: -1, s: -1}]
    end
  end
end
