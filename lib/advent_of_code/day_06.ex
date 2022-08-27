defmodule AdventOfCode.Day06 do
  defp parse(args) do
    args
    |> String.split(["\n\n"], trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end

  defp unique_answers(group) do
    group
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.into(MapSet.new())
    |> Enum.count()
  end

  def part1(args) do
    parse(args)
    |> Enum.map(&unique_answers/1)
    |> Enum.sum()
  end

  defp unanimous_answers(group) do
    group
    |> Enum.map(&MapSet.new(String.graphemes(&1)))
    |> Enum.reduce(&MapSet.intersection/2)
    |> Enum.count()
  end

  def part2(args) do
    parse(args)
    |> Enum.map(&unanimous_answers/1)
    |> Enum.sum()
  end
end
