defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence |> normalize |> find_words |> count_words
  end

  defp normalize(sentence) do
    String.downcase(sentence)
  end

  defp find_words(sentence) do
    Regex.scan(~r/[a-z0-9À-ž-]+/i, sentence) |> List.flatten
  end

  defp count_words(words) do
    Enum.reduce(words, Map.new, fn(word, dict) ->
      Map.update(dict, word, 1, &(&1 + 1))
    end)
  end
end
