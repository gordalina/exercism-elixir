defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    Task.async_stream(texts, &letter_count/1, max_concurrency: workers)
    |> Enum.reduce(%{}, fn ({:ok, lm}, acc) ->
        Map.merge(acc, lm, fn (_k, v1, v2) -> v1 + v2 end)
    end)
  end

  def letter_count(texts) do
    String.downcase(texts)
    |> String.graphemes()
    |> Enum.filter(&(String.match?(&1, ~r/[\p{L}]/u)))
    |> Enum.reduce(%{}, fn (letter, map) -> Map.update(map, letter, 1, &(&1 + 1)) end)
  end
end
