defmodule RobotSimulator do
  @directions [ :north, :east, :south, :west ]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: {any}
  def create(direction \\ :north, position \\ {0, 0}) do
    with {:ok} <- validate_direction(direction),
         {:ok} <- validate_position(position),
         do: %{direction: direction, position: position}
  end

  defp validate_position({x, y}) when is_integer(x) and is_integer(y), do: {:ok}
  defp validate_position(_), do: {:error, "invalid position"}

  defp validate_direction(direction) when direction in @directions, do: {:ok}
  defp validate_direction(_), do: {:error, "invalid direction"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    try do
      simulate!(robot, instructions)
    rescue
      e in RuntimeError -> {:error, e.message}
    end
  end

  def simulate!(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce(robot, &(move(&2, &1)))
  end

  def move(%{position: {x, y}, direction: :north} = robot, "A"), do: %{robot | position: { x, y + 1 }}
  def move(%{position: {x, y}, direction: :south} = robot, "A"), do: %{robot | position: { x, y - 1 }}
  def move(%{position: {x, y}, direction: :east}  = robot, "A"), do: %{robot | position: { x + 1, y }}
  def move(%{position: {x, y}, direction: :west}  = robot, "A"), do: %{robot | position: { x - 1, y }}

  def move(%{direction: :north} = robot, "R"), do: %{robot | direction: :east  }
  def move(%{direction: :south} = robot, "R"), do: %{robot | direction: :west }
  def move(%{direction: :east}  = robot, "R"), do: %{robot | direction: :south }
  def move(%{direction: :west}  = robot, "R"), do: %{robot | direction: :north }

  def move(%{direction: :north} = robot, "L"), do: %{robot | direction: :west  }
  def move(%{direction: :south} = robot, "L"), do: %{robot | direction: :east }
  def move(%{direction: :east}  = robot, "L"), do: %{robot | direction: :north }
  def move(%{direction: :west}  = robot, "L"), do: %{robot | direction: :south }

  def move(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
