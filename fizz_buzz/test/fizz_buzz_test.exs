defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  test "tests fizz buzz" do
    assert FizzBuzz.run(1) == 1
    assert FizzBuzz.run(2) == 2
    assert FizzBuzz.run(3) == "Fizz"
    assert FizzBuzz.run(4) == 4
    assert FizzBuzz.run(5) == "Buzz"
    assert FizzBuzz.run(7) == 7
    assert FizzBuzz.run(8) == 8
    assert FizzBuzz.run(9) == "Fizz"
    assert FizzBuzz.run(10) == "Buzz"
    assert FizzBuzz.run(11) == 11
    assert FizzBuzz.run(13) == 13
    assert FizzBuzz.run(15) == "FizzBuzz"
  end
end
