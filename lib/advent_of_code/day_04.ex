defmodule AdventOfCode.Day04 do
  @spec parse(binary) :: list(map())
  defp parse(args) do
    args
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn passport ->
      passport
      |> String.split([" ", "\n"], trim: true)
      |> Map.new(fn passport -> String.split(passport, ":") |> List.to_tuple() end)
    end)
  end

  @spec valid_passport?(map(), map()) :: boolean()
  defp valid_passport?(
         %{
           "byr" => _,
           "pid" => _,
           "ecl" => _,
           "eyr" => _,
           "hcl" => _,
           "hgt" => _,
           "iyr" => _
         } = passport,
         valid_formats
       ) do
    passport
    |> Enum.map(fn {k, v} ->
      case Map.get(valid_formats, k, nil) do
        nil -> true
        pattern -> Regex.match?(pattern, v)
      end
    end)
    |> Enum.all?()
  end

  defp valid_passport?(_passport, _valid_formats), do: false

  @spec part1(binary) :: non_neg_integer
  def part1(args) do
    passports = parse(args)

    all_formats_are_valid = %{
      "byr" => ~r/^.*$/,
      "iyr" => ~r/^.*$/,
      "eyr" => ~r/^.*$/,
      "hgt" => ~r/^.*$/,
      "hcl" => ~r/^.*$/,
      "ecl" => ~r/^.*$/,
      "pid" => ~r/^.*$/
    }

    passports
    |> Enum.filter(&valid_passport?(&1, all_formats_are_valid))
    |> length()
  end

  @spec part2(binary) :: non_neg_integer
  def part2(args) do
    passports = parse(args)

    valid_formats = %{
      "byr" => ~r/^(19[2-9]\d|200[0-2])$/,
      "iyr" => ~r/^(201\d|2020)$/,
      "eyr" => ~r/^(202\d|2030)$/,
      "hgt" => ~r/^(([5-6]\d|7[0-6])in|(\d[5-8]\d|\d9[0-3])cm)$/,
      "hcl" => ~r/^#[0-9a-f]{6}$/,
      "ecl" => ~r/^(amb|blu|brn|gry|grn|hzl|oth)$/,
      "pid" => ~r/^[0-9]{9}$/
    }

    passports
    |> Enum.map(&valid_passport?(&1, valid_formats))
    |> Enum.filter(& &1)
    |> length()
  end
end
