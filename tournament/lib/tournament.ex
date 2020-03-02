defmodule Tournament do
  @default %{
    :MP => 0,
    :W => 0,
    :L => 0,
    :D => 0,
    :P => 0
  }
  @header "Team                           | MP |  W |  D |  L |  P"

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.filter(&(valid?(&1)))
    |> Enum.map(&(String.split(&1, ";")))
    |> Enum.reduce(%{}, &(reducer/2))
    |> print
  end

  defp print(map) do
    map
    |> winners()
    |> Enum.reduce(@header, fn (name, acc) ->
      stats = Map.get(map, name)
      acc
        <> "\n" <> String.pad_trailing(name, 30)
        <> " | " <> String.pad_leading(Map.get(stats, :MP) |> to_string, 2)
        <> " | " <> String.pad_leading(Map.get(stats, :W) |> to_string, 2)
        <> " | " <> String.pad_leading(Map.get(stats, :D) |> to_string, 2)
        <> " | " <> String.pad_leading(Map.get(stats, :L) |> to_string, 2)
        <> " | " <> String.pad_leading(Map.get(stats, :P) |> to_string, 2)
    end)
  end

  defp winners(map) do
    Map.keys(map)
    |> Enum.sort_by(&(Map.get(Map.get(map, &1), :P)), :desc)
  end

  defp reducer([team, adv, result], acc) do
    case result do
      "win" -> acc |> win(team) |> loss(adv)
      "loss" -> acc |> win(adv) |> loss(team)
      "draw" -> acc |> draw(team) |> draw(adv)
    end
  end

  defp valid?(line) do
    case String.split(line, ";") do
      [_, _, result] -> result in ["win", "loss", "draw"]
      _ -> false
    end
  end

  defp win(map, team) do
    map
    |> Map.update(team, @default, &(&1))
    |> Map.update(team, @default, &(%{&1 | MP: Map.get(&1, :MP, 0) + 1}))
    |> Map.update(team, @default, &(%{&1 | W: Map.get(&1, :W, 0) + 1}))
    |> Map.update(team, @default, &(%{&1 | P: Map.get(&1, :P, 0) + 3}))
  end

  defp loss(map, team) do
    map
    |> Map.update(team, @default, &(&1))
    |> Map.update(team, @default, &(%{&1 | MP: Map.get(&1, :MP, 0) + 1}))
    |> Map.update(team, @default, &(%{&1 | L: Map.get(&1, :L, 0) + 1}))
  end

  defp draw(map, team) do
    map
    |> Map.update(team, @default, &(&1))
    |> Map.update(team, @default, &(%{&1 | MP: Map.get(&1, :MP, 0) + 1}))
    |> Map.update(team, @default, &(%{&1 | D: Map.get(&1, :D, 0) + 1}))
    |> Map.update(team, @default, &(%{&1 | P: Map.get(&1, :P, 0) + 1}))
  end
end
