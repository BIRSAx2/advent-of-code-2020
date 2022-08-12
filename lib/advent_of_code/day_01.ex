defmodule AdventOfCode.Day01 do
  defp parse(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.into(MapSet.new())
  end

  def find_sum(numbers, sum) do
    numbers
    |> Enum.find(&MapSet.member?(numbers, sum - &1))
    |> case do
      nil -> nil
      number -> {number, sum - number}
    end
  end

  def part1(args) do
    numbers = parse(args)

    {a, b} = find_sum(numbers, 2020)
    a * b
  end

  defp find_three_sum(numbers, sum) do
    a = Enum.find(numbers, &find_sum(numbers, sum - &1))
    
    {b, c} = find_sum(numbers, sum - a)
    {a, b, c}
  end

  def part2(args) do
    numbers = parse(args)

    {a, b, c} = find_three_sum(numbers, 2020)

    a * b * c
  end
end
