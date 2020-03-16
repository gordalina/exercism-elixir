defmodule FizzBuzz do
  @moduledoc """
  Documentation for `FizzBuzz`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FizzBuzz.run(15)
      "FizzBuzz"

  """
  def run(n) do
    run(rem(n, 3), rem(n, 5), n)
  end

  defp run(0, 0, _), do: "FizzBuzz"
  defp run(0, _, _), do: "Fizz"
  defp run(_, 0, _), do: "Buzz"
  defp run(_, _, n), do: n
end
