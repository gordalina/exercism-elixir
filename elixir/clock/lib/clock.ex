defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(h, m) when h < 0, do: new(h + 24, m)
  def new(h, m) when h >= 24, do: new(h - 24, m)
  def new(h, m) when m < 0, do: new(h - 1, m + 60)
  def new(h, m) when m >= 60, do: new(h + 1, m - 60)
  def new(h, m), do: %Clock{hour: h, minute: m}

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute), do: new(hour, minute + add_minute)

  defimpl String.Chars do
    def to_string(%Clock{hour: h, minute: m}), do: pad(h) <> ":" <> pad(m)
    def pad(n), do: "00#{n}" |> String.slice(-2..-1)
  end
end
