defmodule HexGrid.Hex do
  alias HexGrid.Hex, as: Hex

  @moduledoc """
  Hex Tile module. See this excellent article for
  reference:

  http://www.redblobgames.com/grids/hexagons/implementation.html
  """

  defstruct q: 0, r: 0, s: 0
  @typedoc "Hex Tile"
  @opaque t :: %__MODULE__{q: number, r: number, s: number}

  @doc ~S"""
  Creates a new hex tile
  Throws an ArgumentError if q + r + s != 0

  ## Examples

  iex> Hex.new!(0, 1, -1)
  %Hex{q: 0, r: 1, s: -1}

  iex> Hex.new!(0, 1, 1)
  ** (ArgumentError) Invalid coordinates in hex given, coordinate scalars q, r and s in %Hex{q:0, r:1, s:1} do not sum to 0
  """
  @spec new(number, number, number) :: t
  def new!(q, r, s) do
    if q + r + s != 0 do
      raise ArgumentError, message: "Invalid coordinates in hex given, coordinate scalars q, r and s in %Hex{q:#{q}, r:#{r}, s:#{s}} do not sum to 0"
    end

    %Hex{q: q, r: r, s: s}
  end

  @doc ~S"""
  Creates a new hex tile

  ## Examples

  iex> Hex.new(0, 1, -1)
  {:ok, %Hex{q: 0, r: 1, s: -1}}

  iex> Hex.new(0, 1, 1)
  {:error, "Invalid coordinates in hex given, coordinate scalars q, r and s in %Hex{q:0, r:1, s:1} do not sum to 0"}
  """
  @spec new(number, number, number) :: {:ok, t} | {:error, String.t()}
  def new(q, r, s) do
    try do
      {:ok, new!(q, r, s)}
    rescue
      e in ArgumentError -> {:error, e.message}
    end
  end

  @doc ~S"""
  Adds two hexes together

  ## Examples

  iex> Hex.add(Hex.new!(0, 1, -1), Hex.new!(0, 1, -1))
  %Hex{q: 0, r: 2, s: -2}
  """
  @spec add(t, t) :: t
  def add(first, second) do
    Hex.new!(first.q + second.q, first.r + second.r, first.s + second.s)
  end

  @doc ~S"""
  Subtracts two hexes

  ## Examples

  iex> Hex.sub(Hex.new!(0, 0, 0), Hex.new!(0, 1, -1))
  %Hex{q: 0, r: -1, s: 1}
  """
  def sub(first, second) do
    Hex.new!(first.q - second.q, first.r - second.r, first.s - second.s)
  end

  @doc ~S"""
  Multiples hex by scalar

  ## Examples

  iex> Hex.mul(Hex.new!(0, 1, -1), 2)
  %Hex{q: 0, r: 2, s: -2}
  """
  @spec mul(t, integer) :: t
  def mul(hex, scalar) do
    Hex.new!(hex.q * scalar, hex.r * scalar, hex.s * scalar)
  end

  @doc ~S"""
  Gets the length of a hex

  ## Examples

  iex> Hex.length(Hex.new!(0, 0, 0))
  0

  iex> Hex.length(Hex.new!(0, 1, -1))
  1
  """
  @spec length(t) :: integer
  def length(hex) do
    round((abs(hex.q) + abs(hex.r) + abs(hex.s)) / 2)
  end

  @doc ~S"""
  Calculates the distance between two hexes

  ## Examples

  iex> Hex.distance(Hex.new!(0, 0, 0), Hex.new!(0, 1, -1))
  1

  iex> Hex.distance(Hex.new!(0, 0, 0), Hex.new!(1, 1, -2))
  2

  iex> Hex.distance(Hex.new!(0, 0, 0), Hex.new!(-1, 5, -4))
  5
  """
  @spec distance(t, t) :: integer
  def distance(first, second) do
    Hex.length(sub(first, second))
  end

  @doc ~S"""
  Gets a hex with a given direction.
  Allowed values are 0-5, inclusive.

  0 is hex immediately to the right. As the value increases
  the direction vector rotates counter-clockwise.

  ## Examples

  iex> Hex.cube_direction(0)
  %Hex{q: 1, r: -1, s: 0}

  iex> Hex.cube_direction(1)
  %Hex{q: 1, r: 0, s: -1}

  iex> Hex.cube_direction(6)
  :error
  """
  @spec cube_direction(integer) :: t | :error
  def cube_direction(dir) do
    direction(dir)
  end

  @doc ~S"""
  Gets the neighbour of the hex

  ## Examples

  iex> Hex.neighbour(Hex.new!(0, 0, 0), 0)
  %Hex{q: 1, r: -1, s: 0}

  iex> Hex.neighbour(Hex.new!(3, -3, 0), 1)
  %Hex{q: 4, r: -3, s: -1}
  """
  @spec neighbour(t, integer) :: t
  def neighbour(hex, dir) do
    add(hex, direction(dir))
  end

  @doc ~S"""
  Gets all hexes neighbours

  ## Examples

  iex> Hex.neighbours(Hex.new!(0, 0, 0))
  [
  %Hex{q: 1, r: 0, s: -1},
  %Hex{q: 0, r: 1, s: -1},
  %Hex{q: -1, r: 1, s: 0},
  %Hex{q: -1, r: 0, s: 1},
  %Hex{q: 0, r: -1, s: 1}
  ]
  """
  @spec neighbours(t) :: [t]
  def neighbours(hex) do
    Enum.map(1..5, fn (x) -> neighbour(hex, x) end)
  end

  @doc ~S"""
  Gets all hexes within a certain distance of the given hex

  ## Examples

  iex> Hex.neighbourhood(Hex.new!(0, 1, -1), 0)
  [
    %Hex{q: 0, r: 1, s: -1},
  ]

  iex> Hex.neighbourhood(Hex.new!(0, 1, -1), 2)
  [%HexGrid.Hex{q: -2, r: 1, s: 1}, %HexGrid.Hex{q: -2, r: 2, s: 0},
   %HexGrid.Hex{q: -2, r: 3, s: -1}, %HexGrid.Hex{q: -1, r: 0, s: 1},
   %HexGrid.Hex{q: -1, r: 1, s: 0}, %HexGrid.Hex{q: -1, r: 2, s: -1},
   %HexGrid.Hex{q: -1, r: 3, s: -2}, %HexGrid.Hex{q: 0, r: -1, s: 1},
   %HexGrid.Hex{q: 0, r: 0, s: 0}, %HexGrid.Hex{q: 0, r: 1, s: -1},
   %HexGrid.Hex{q: 0, r: 2, s: -2}, %HexGrid.Hex{q: 0, r: 3, s: -3},
   %HexGrid.Hex{q: 1, r: -1, s: 0}, %HexGrid.Hex{q: 1, r: 0, s: -1},
   %HexGrid.Hex{q: 1, r: 1, s: -2}, %HexGrid.Hex{q: 1, r: 2, s: -3},
   %HexGrid.Hex{q: 2, r: -1, s: -1}, %HexGrid.Hex{q: 2, r: 0, s: -2},
   %HexGrid.Hex{q: 2, r: 1, s: -3}]
  """
  @spec neighbourhood(t, non_neg_integer) :: [t]
  def neighbourhood(hex, distance) do
    for dq <- -distance..distance,
        dr <- Enum.max([-distance, -dq - distance])..Enum.min([distance, -dq + distance]) do
          Hex.add(hex, Hex.new!(dq, dr, -dq - dr))
        end
  end

  defp direction(dir) do
    case dir do
      0 -> Hex.new!(+1, -1, 0)
      1 -> Hex.new!(+1, 0, -1)
      2 -> Hex.new!(0, +1, -1)
      3 -> Hex.new!(-1, +1, 0)
      4 -> Hex.new!(-1, 0, +1)
      5 -> Hex.new!(0, -1, +1)
      _ -> :error
    end
  end
end
