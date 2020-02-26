defmodule Bob do
  def hey(input) do
    cond do
      mute?(input) -> "Fine. Be that way!"
      yell?(input) and question?(input) ->
        "Calm down, I know what I'm doing!"
      yell?(input) ->
        "Whoa, chill out!"
      question?(input) ->
        "Sure."
      true -> "Whatever."
    end
  end

  defp yell?(input) do
    input == String.upcase(input) and String.match?(input, ~r/[[:alpha:]]+/)
  end

  defp question?(input) do
    input |> String.trim() |> String.match?(~r/\?$/)
  end

  defp mute?(input) do
    input |> String.trim() |> String.length() == 0
  end
end
