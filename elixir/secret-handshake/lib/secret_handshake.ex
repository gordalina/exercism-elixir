defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump
  10000 = Reverse the order of the operations in the secret handshake
  100000 =
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(0), do: []
  def commands(1), do: ["wink"]
  def commands(2), do: ["double blink"]
  def commands(4), do: ["close your eyes"]
  def commands(8), do: ["jump"]
  def commands(code) when code >= 32, do: []
  def commands(code) when code >= 16, do: Enum.reverse(commands(code-16))
  def commands(code) when code >= 8, do: commands(code - 8) ++ commands(8)
  def commands(code) when code >= 4, do: commands(code - 4) ++ commands(4)
  def commands(code) when code >= 2, do: commands(code - 2) ++ commands(2)
  def commands(code) when code >= 1, do: commands(code - 1) ++ commands(1)
end
