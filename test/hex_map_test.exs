defmodule HexGrid.Map.Test do
  alias HexGrid.Map, as: HexMap
  alias HexGrid.Hex, as: Hex

  use ExUnit.Case, async: true
  doctest HexMap

  test "inserting map tile should insert tile" do
    {:ok, map} = HexMap.new()
    {result, map} = HexMap.insert(map, Hex.new(0, 0, 0))

    assert result == :ok
    assert map != nil
  end

  test "inserting map tile when tile already exists should fail" do
    {:ok, map} = HexMap.new()
    {_, map} = HexMap.insert(map, Hex.new(0, 0, 0))

    assert HexMap.insert(map, Hex.new(0, 0, 0)) == {:error, "Tile already exists"}
  end

  test "setting value on non-existing tile should fail" do
    {_, map} = HexMap.new()

    assert HexMap.set(map, Hex.new(0, 0, 0), :hello, "world") == {:error, "Tile does not exist"}
  end

  test "setting value on tile should succeed" do
    hex = Hex.new(0, 0, 0)
    {:ok, map} = HexMap.new()
    {:ok, map} = HexMap.insert(map, hex)

    # set some values
    {:ok, map} = HexMap.set(map, hex, :hello, :world)
    {:ok, map} = HexMap.set(map, hex, :other, :something)
    {:ok, map} = HexMap.set(map, hex, "other", "parameter")
    {:ok, map} = HexMap.set(map, hex, :height, 5)

    assert map != nil
    assert HexMap.get(map, hex, :hello)  == {:ok, :world}
    assert HexMap.get(map, hex, :other)  == {:ok, :something}
    assert HexMap.get(map, hex, "other") == {:ok, "parameter"}
    assert HexMap.get(map, hex, :height) == {:ok, 5}
  end

  test "getting value should succeed" do
    hex = Hex.new(0, 0, 0)
    {_, map} = HexMap.new()
    {_, map} = HexMap.insert(map, hex)
    {_, map} = HexMap.set(map, hex, :hello, :world)

    assert HexMap.get(map, hex, :hello) == {:ok, :world}
  end

  test "getting value not set should return nil" do
    hex = Hex.new(0, 0, 0)
    {_, map} = HexMap.new()
    {_, map} = HexMap.insert(map, hex)
    {_, map} = HexMap.set(map, hex, :hello, :world)

    assert HexMap.get(map, hex, :missing) == {:ok, nil}
  end
end
