defmodule GCDTest do
  use ExUnit.Case
  doctest GCD

  test "test gcd" do
    assert GCD.of(4, 8) == 4
  end
end
