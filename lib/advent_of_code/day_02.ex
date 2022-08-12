defmodule AdventOfCode.Day02 do
  defp parse(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      Regex.named_captures(~r/(?<min>\d+)-(?<max>\d+) (?<char>\w): (?<pwd>\w+)/, line)
      |> Map.update!("min", &String.to_integer/1)
      |> Map.update!("max", &String.to_integer/1)
    end)
  end

  defp is_valid_password(%{"min" => min, "max" => max, "char" => char, "pwd" => pwd}, :with_freq) do
    pwd
    |> String.graphemes()
    |> Enum.count(&(&1 == char))
    |> then(&(&1 in min..max))
  end

  defp is_valid_password(
         %{"min" => min, "max" => max, "char" => char, "pwd" => pwd},
         :with_position
       ) do
    valid_position_1 = String.at(pwd, min - 1) == char
    valid_position_2 = String.at(pwd, max - 1) == char
    valid_position_1 != valid_position_2
  end

  def part1(args) do
    passwords_with_policy = parse(args)

    passwords_with_policy
    |> Enum.filter(&is_valid_password(&1, :with_freq))
    |> length()
  end

  def part2(args) do
    passwords_with_policy = parse(args)

    passwords_with_policy
    |> Enum.filter(&is_valid_password(&1, :with_position))
    |> length()
  end
end
