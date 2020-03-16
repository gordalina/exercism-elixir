defmodule GCD do
  @moduledoc """
  Documentation for `GCD`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GCD.of(3, 15)
      3

  """
  def of(x, 0), do: x
  def of(x, y), do: of(y, rem(x, y))
end
