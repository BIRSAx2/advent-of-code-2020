defmodule AdventOfCode.Day03 do
  defp parse(args) do
    tree_map =
      for {line, y} <- String.split(args, "\n", trim: true) |> Enum.with_index(),
          {char, x} <- String.split(line, "", trim: true) |> Enum.with_index(),
          into: %{} do
        {{x, y},
         case char do
           "#" -> 1
           "." -> 0
         end}
      end

    {bottom_right, _} = Enum.max_by(tree_map, fn {k, _v} -> k end)

    {tree_map, bottom_right}
  end

  @spec is_tree(map, integer, {integer, integer}) :: integer
  def is_tree(tree_map, max_x, {x, y}) do
    Map.get(
      tree_map,
      {
        rem(x, max_x + 1),
        y
      },
      0
    )
  end

  @spec traverse_count_tree(map, {integer, integer}, {integer, integer}) :: integer
  def traverse_count_tree(tree_map, {max_x, max_y}, {slope_x, slope_y}) do
    {count, _} =
      0..(max_y - 1)
      |> Enum.reduce({0, {slope_x, slope_y}}, fn _, {count, {x, y}} ->
        count = count + is_tree(tree_map, max_x, {x, y})

        {count, {x + slope_x, y + slope_y}}
      end)

    count
  end

  def part1(args) do
    {tree_map, bottom_right} = parse(args)
    traverse_count_tree(tree_map, bottom_right, {3, 1})
  end

  def part2(args) do
    {tree_map, bottom_right} = parse(args)

    slopes = [
      {1, 1},
      {3, 1},
      {5, 1},
      {7, 1},
      {1, 2}
    ]

    slopes
    |> Enum.map(&traverse_count_tree(tree_map, bottom_right, &1))
    |> Enum.reduce(&(&1 * &2))
  end
end
