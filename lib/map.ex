defmodule HexGrid.Map do

  @moduledoc """
  Map for Hexes. Allows for adding/removing tiles
  and setting data on them.
  """

  defstruct [data: Map.new]
  @typedoc "Map"
  @type t :: %HexGrid.Map{data: Map.t}

  @typedoc "Result returned from Map functions"
  @type result :: {:ok, term} | {:error, term}

  @doc ~S"""
  Creates an empty map

  Examples:

  iex> HexGrid.Map.new()
  {:ok, %HexGrid.Map{}}
  """
  @spec new() :: result
  def new() do
    {:ok, %HexGrid.Map{}}
  end

  @doc ~S"""
  Creates a Hexagonal-shaped map with a given radius

  Examples:

  iex> HexGrid.Map.new_hex(0)
  {:ok, %HexGrid.Map{data: %{{0, 0, 0} => %{}}}}
  """
  @spec new_hex(integer) :: result
  def new_hex(radius) do
    data = for q <- (-radius)..radius,
      r1 = max(-radius, -q - radius),
      r2 = min( radius, -q + radius),
      r <- r1..r2,
      do: {{q, r, -q - r}, %{}},
      into: Map.new

    {:ok, %HexGrid.Map{data: data}}
  end

  @doc ~S"""
  Adds the tile to the map
  """
  @spec insert(t, HexGrid.Hex.t) :: result
  def insert(map, hex) do
    case Map.get(map.data, key_of(hex)) do
      nil -> {:ok, update_in(map.data, &(Map.put(&1, key_of(hex), %{})))}
      _   -> {:error, "Tile already exists"}
    end
  end

  @doc """
  Sets the arbitrary value on a map.
  """
  @spec set(t, HexGrid.Hex.t, any, any) :: result
  def set(map, hex, key, value) do
    # we only want to set if tile exists
    case Map.get(map.data, key_of(hex)) do
      nil -> {:error, "Tile does not exist"}
      _   -> {:ok, %HexGrid.Map{data: put_in(map.data, [key_of(hex), key], value)}}
    end
  end

  @doc """
  Gets the value from the map.
  """
  @spec get(t, HexGrid.Hex.t, any) :: any
  def get(map, hex, key) do
    case Map.get(map.data, key_of(hex)) do
      nil -> {:error, "Tile does not exist"}
      _   -> {:ok, get_in(map.data, [key_of(hex), key])}
    end
  end

  defp key_of(hex) do
    {hex.r, hex.q, hex.s}
  end
end
