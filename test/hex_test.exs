defmodule HexTileTest do
  use ExUnit.Case, async: true
  doctest Hex

  test "init returns hex" do
    assert Hex.new(1, 1, 1) != nil
  end

  test "two tiles with same coordinates equal" do
    first = Hex.new(1, 1, 1)
    second = Hex.new(1, 1, 1)

    assert first == second
  end

  test "two tiles with different coordinates do not equal" do
    first = Hex.new(0, 0, 0)
    second = Hex.new(1, 1, 1)
    assert first != second
  end

  test "adding two hexes" do
    first = Hex.new(1, 1, 1)
    second = Hex.new(2, 2, 2)
    assert Hex.add(first, second) == Hex.new(3, 3, 3)
  end

  test "subtracting two hexes" do
    first = Hex.new(1, 1, 1)
    second = Hex.new(2, 2, 2)
    assert Hex.sub(first, second) == Hex.new(-1, -1, -1)
  end

  test "multiplying two hexes" do
    first = Hex.new(2, 2, 2)
    second = Hex.new(2, 2, 2)
    assert Hex.mul(first, second) == Hex.new(4, 4, 4)
  end
end
