# HexGrid

Create hexagonal grids in Elixir. Provides basic computational and mapping support.

Work is based on [this excellent article](http://www.redblobgames.com/grids/hexagons/implementation.html) from [redblobgames](http://www.redblobgames.com/). 

_See [hex package](https://hex.pm/packages/hexgrid/1.0.0) and [docs](https://hexdocs.pm/hexgrid/1.0.0) for more details._

## Installation

The package can be installed by listing it as a `hex` dependency:

```
def deps do
  [{:hexgrid, "~> 1.0"}]
end
``` 

## Usage

```
alias HexGrid.Map, as: HexMap
alias HexGrid.Hex, as: Hex
```

## API

### Hex Tile

#### new(q, r, s)

Create a tile in a cube coordinate system.

Example:

```
Hex.new(1, 2, 3)
```

#### neighbour(hex, direction)

Gets the neighbouring hex. Neighbours are just offsets on the given hex:

```
0 -> Hex.new(+1, -1, 0)
1 -> Hex.new(+1, 0, -1)
2 -> Hex.new(0, +1, -1)
3 -> Hex.new(-1, +1, 0)
4 -> Hex.new(-1, 0, +1)
5 -> Hex.new(0, -1, +1)
```

Example:

```
Hex.neighbours(Hex.new(0, 0, 0))
```

#### neighbours(hex)

For a given hex tile, get all adjacent tiles. 

Example:

```
Hex.neightbours(Hex.new(0, 0, 0))
```

### Map

Provides support for creating and maintining tile structures, as well as containing tile data. 

_Note: Examples alias `HexGrid.Map` as `Map`_

#### new()

Creates an empty map.


Example:

```
Map.new()
```

#### new_hex(radius)

Creastes a hexagonal-shaped map with a given radius.

Example:

```
Map.new_hex(5)
```

#### insert(map, tile)

Adds tile to the map. 

Example:

```
{:ok, map} = HexMap.new()
{result, map} = HexMap.insert(map, Hex.new(0, 0, 0))
```

#### set(map, tile, key, value)

Sets an arbitrary value on a map, for a given tile.

Example:

```
hex = Hex.new(0, 0, 0)
{_, map} = HexMap.new()
{_, map} = HexMap.insert(map, hex)

{_, map} = HexMap.set(map, hex, :hello, :world)
```

#### get(map, tile, key)

Gets the value from the map, for a given tile.

Example:

```
hex = Hex.new(0, 0, 0)
{_, map} = HexMap.new()
{_, map} = HexMap.insert(map, hex)
{_, map} = HexMap.set(map, hex, :hello, :world)

assert HexMap.get(map, hex, :hello) == {:ok, :world}
```

### Pathfinding

**TODO**
