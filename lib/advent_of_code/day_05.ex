defmodule AdventOfCode.Day05 do
  defp parse(args) do
    String.split(args, "\n", trim: true)
  end

  defp take_upper_half(lower..upper) do
    lower..(floor((upper + lower + 1) / 2) - 1)
  end

  defp take_lower_half(lower..upper) do
    floor((upper + lower + 1) / 2)..upper
  end

  defp get_seat_id(seat) do
    {row.._, col.._} =
      seat
      |> String.split("", trim: true)
      |> Enum.reduce({0..127, 0..7}, fn
        "F", {rows, cols} ->
          {take_upper_half(rows), cols}

        "B", {rows, cols} ->
          {take_lower_half(rows), cols}

        "L", {rows, cols} ->
          {rows, take_upper_half(cols)}

        "R", {rows, cols} ->
          {rows, take_lower_half(cols)}
      end)

    row * 8 + col
  end

  def part1(args) do
    seats = parse(args)

    seats
    |> Enum.map(&get_seat_id/1)
    |> Enum.max()
  end

  def part2(args) do
    seats = parse(args)

    seat_ids = Enum.map(seats, &get_seat_id/1)

    [635]
    |> Enum.reduce_while(MapSet.new(seat_ids), fn el, acc ->
      cond do
        MapSet.member?(acc, el - 1) and MapSet.member?(acc, el + 1) ->
          {:cont, acc}

        not MapSet.member?(acc, el + 1) and
            MapSet.member?(acc, el + 2) ->
          {:halt, el + 1}

        not MapSet.member?(acc, el - 1) and
            MapSet.member?(acc, el - 2) ->
          {:halt, el - 1}

        true ->
          {:cont, acc}
      end
    end)
  end
end
