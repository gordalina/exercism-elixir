defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    Enum.count(strand, &(&1 == nucleotide))
    #Enum.filter(strand, fn nuc -> nuc == nucleotide end) |> length
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    Map.new(@nucleotides, &({&1, count(strand, &1)}))
    # Enum.reduce(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0}, fn (value, acc) ->
    #   Map.update(acc, value, 0, &(&1 + 1))
    # end)
  end
end
