defmodule AdventOfCode.Day05 do
  defp parse(args) do
    String.split(args, "\n", trim: true)
  end

  def get_seat_id(boarding_pass) do
    boarding_pass
    |> String.graphemes()
    |> Enum.map(&char_to_digit/1)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, exp}, acc -> acc + Bitwise.bsl(digit, exp) end)
  end

  def char_to_digit(str) do
    case str do
      "B" -> 1
      "F" -> 0
      "R" -> 1
      "L" -> 0
    end
  end

  def part1(args) do
    boarding_passes = parse(args)

    boarding_passes
    |> Enum.map(&get_seat_id/1)
    |> Enum.max()
  end

  def part2(args) do
    boarding_passes = parse(args)

    [prev, _next] =
      boarding_passes
      |> Enum.sort()
      |> Enum.map(&get_seat_id/1)
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.filter(fn [prev, next] -> next - prev == 2 end)
      |> hd()

    prev + 1
  end
end
