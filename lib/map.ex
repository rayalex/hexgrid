defmodule HexGrid.Map do

  @moduledoc """
  Map for Hexes. Allows for adding/removing tiles
  and setting data on them.
  """

  defstruct [data: Map.new]
  @type t :: %HexGrid.Map{data: Map.t}

  @doc ~S"""
  Creates empty map

  Examples:

  iex> HexGrid.Map.new()
  {:ok, %HexGrid.Map{}}
  """
  def new() do
    {:ok, %HexGrid.Map{}}
  end

  @doc ~S"""
  Creates map based on Hexagonal grid. Grid radius should
  be provided.

  Examples:

  iex> HexGrid.Map.new_hex(0)
  {:ok, %HexGrid.Map{data: %{{0, 0, 0} => %{}}}}
  """
  def new_hex(radius) do
    data = for q <- (-radius)..radius,
      r1 = max(-radius, -q - radius),
      r2 = min(radius, -q + radius),
      r <- r1..r2,
      do: {{q, r, -q - r}, %{}},
      into: Map.new

    {:ok, %HexGrid.Map{data: data}}
  end

  @doc ~S"""
  Adds the tile to the map.
  """
  def insert(map, hex) do
    {:ok, update_in(map.data, &(Map.put(&1, {hex.r, hex.q, hex.s}, %{})))}
  end

  @doc """
  Sets the arbitrary value on a map.
  """
  def set(map, hex, key, value) do
    # fail if tile does not exist
    existing = Map.get(map, {hex.r, hex.q, hex.s})
    return = case existing do
      v -> put_in(map.data, [{hex.r, hex.q, hex.s}, key], value)
  #   v -> {:ok, update_in(map.data, &(Map.put(&1, {hex.r, hex.q, hex.s}, %{key => value})))}
      _ -> {:error, nil}
    end
    # if it does, update in-place

    # return updated value
    {:ok, %HexGrid.Map{data: return}}

  end

  def get(map, hex, key, value) do
    nil
  end

end
