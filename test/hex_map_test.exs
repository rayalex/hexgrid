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
    
  end

  test "setting value on non-existing tile should fail" do
    
  end

  test "setting value on tile should succeed" do
    hex = Hex.new(0, 0, 0)
    {:ok, map} = HexMap.new()
    {:ok, map} = HexMap.insert(map, hex)

    # set some value
    {result, map} = HexMap.set(map, hex, :hello, :world)
    IO.inspect(map)

    {result, map} = HexMap.set(map, hex, :other, :something)
    IO.inspect(map)

    {result, map} = HexMap.set(map, hex, "other", "parameter")
    IO.inspect(map)

    {result, map} = HexMap.set(map, hex, :height, 5)
    IO.inspect(map)

    assert result == :ok
    assert map != nil
  end

end
