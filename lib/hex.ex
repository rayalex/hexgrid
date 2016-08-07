defmodule Hex do
  @moduledoc """
  Hex module. See this excelent article for
  reference:

  http://www.redblobgames.com/grids/hexagons/implementation.html
  """

  defstruct q: 0, r: 0, s: 0
  @type t :: %Hex{q: number, r: number, s: number}

  @doc ~S"""
  Creates a new hex tile
  """
  def new(q, r, s) do
    %Hex{q: q, r: r, s: s}
  end

  @doc ~S"""
  Adds two hexes together.

  ## Examples

  iex> Hex.add(%Hex{q: 1, r: 1, s: 1}, %Hex{q: 1, r: 1, s: 1})
  %Hex{q: 2, r: 2, s: 2}
  """
  def add(first, second) do
    %Hex{q: first.q + second.q, r: first.r + second.r, s: first.s + second.s}
  end

  @doc ~S"""
  Subtracts two Hexes

  ## Examples

  iex> Hex.sub(Hex.new(0, 0, 0), Hex.new(1, 1, 1))
  %Hex{q: -1, r: -1, s: -1}
  """
  def sub(first, second) do
    %Hex{q: first.q - second.q, r: first.r - second.r, s: first.s - second.s}
  end

  @doc ~S"""
  Multiples two hexes together

  ## Examples

  iex> Hex.mul(Hex.new(2, 2, 2), Hex.new(3, 3, 3))
  %Hex{q: 6, r: 6, s: 6}
  """
  def mul(first, second) do
    %Hex{q: first.q * second.q, r: first.r * second.r, s: first.s * second.s}
  end

  @doc ~S"""
  Gets the length of a hex from the origin

  ## Examples

  iex> Hex.length(Hex.new(0, 0, 0))
  0

  iex> Hex.length(Hex.new(1, 1, 1))
  2
  """
  def length(hex) do
    round((abs(hex.q) + abs(hex.r) + abs(hex.s)) / 2)
  end

  @doc ~S"""
  Calculates the distance between two hexes

  ## Examples

  iex> Hex.distance(Hex.new(0, 0, 0), Hex.new(1, 1, 1))
  2

  iex> Hex.distance(Hex.new(0, 0, 0), Hex.new(1, 1, -2))
  2

  iex> Hex.distance(Hex.new(0, 0, 0), Hex.new(-1, 5, -4))
  5
  """
  def distance(first, second) do
    Hex.length(sub(first, second))
  end

  @doc ~S"""
  Gets the direction. Allowed values are 0-5, inclusive.

  0 is hex immediately to the right. As the value increases
  the direction vector rotates around counter-clockwise.

  ## Examples

  iex> Hex.cube_direction(0)
  %Hex{q: 1, r: -1, s: 0}

  iex> Hex.cube_direction(1)
  %Hex{q: 1, r: 0, s: -1}

  iex> Hex.cube_direction(6)
  :error
  """
  def cube_direction(dir) do
    direction(dir)
  end

  @doc ~S"""
  Gets the neighbour of the hex

  ## Examples

  iex> Hex.neighbour(Hex.new(0, 0, 0), 0)
  %Hex{q: 1, r: -1, s: 0}

  iex> Hex.neighbour(Hex.new(3, -3, 0), 1)
  %Hex{q: 4, r: -3, s: -1}
  """
  def neighbour(hex, dir) do
    add(hex, direction(dir))
  end

  @doc ~S"""
  Gets all hexes neighbours

  ## Examples

  iex> Hex.neighbours(Hex.new(0, 0, 0))
  [
  %Hex{q: 1, r: 0, s: -1},
  %Hex{q: 0, r: 1, s: -1},
  %Hex{q: -1, r: 1, s: 0},
  %Hex{q: -1, r: 0, s: 1},
  %Hex{q: 0, r: -1, s: 1}
  ]
  """
  def neighbours(hex) do
    Enum.map(1..5, fn (x) -> neighbour(hex, x) end)
  end

  defp direction(dir) do
    case dir do
      0 -> Hex.new(+1, -1, 0)
      1 -> Hex.new(+1, 0, -1)
      2 -> Hex.new(0, +1, -1)
      3 -> Hex.new(-1, +1, 0)
      4 -> Hex.new(-1, 0, +1)
      5 -> Hex.new(0, -1, +1)
      _ -> :error
    end
  end
end
