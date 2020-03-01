defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()

  def grep(pattern, flags, files) do
    flags = update_flags(flags, files)
    files
    |> Enum.flat_map(&lines/1)
    |> Enum.filter(filter(pattern, flags))
    |> Enum.map(print(flags))
    |> Enum.uniq()
    |> Enum.join("")
  end

  defp update_flags(flags, files) do
    case Enum.count(files) do
      1 -> flags
      _ -> ["-m" | flags]
    end
  end

  defp lines(filename) do
    filename
    |> File.stream!([:read, :utf8])
    |> Enum.reduce([], fn line, acc ->
        acc ++ [{filename, Enum.count(acc) + 1, line}]
       end)
  end

  defp filter(pattern, flags) do
    fn ({_, _, line}) ->
      keep? = cond do
        "-i" in flags -> String.contains?(String.upcase(line), String.upcase(pattern))
        "-x" in flags -> line == pattern <> "\n"
        :else         -> String.contains?(line, pattern)
      end

      cond do
        "-v" in flags -> not keep?
        :else         ->     keep?
      end
    end
  end

  defp print(flags) do
    fn ({filename, num, line}) ->
      cond do
        "-l" in flags -> filename <> "\n"
        "-m" in flags and "-n" in flags -> "#{filename}:#{num}:#{line}"
        "-m" in flags -> "#{filename}:#{line}"
        "-n" in flags -> "#{num}:#{line}"
        :else -> line
      end
    end
  end

  # def grep(pattern, flags, files) do
  #   process_files(pattern, flags, files) |> print()
  # end
  #
  # defp print(list) do
  #   Enum.join(List.flatten(list) ++ [""], "\n")
  # end
  #
  # defp process_files(pattern, flags, files) do
  #   Enum.map files, fn filename ->
  #     filename
  #     |> search(pattern, flags)
  #     |> format(filename, flags, length(files))
  #     |> group(filename, flags)
  #   end
  # end
  #
  # defp search(filename, pattern, flags) do
  #   filename
  #   |> File.read!()
  #   |> String.trim()
  #   |> String.split("\n")
  #   |> Enum.with_index()
  #   |> Enum.filter(filter(pattern, flags))
  # end
  #
  # defp format(list, filename, flags, files) do
  #   Enum.map list, fn {line, number} ->
  #     file =        cond do: (files > 1     -> "#{filename}:"; true -> "")
  #     line_number = cond do: ("-n" in flags -> "#{number+1}:"; true -> "")
  #
  #     "#{file}#{line_number}#{line}"
  #   end
  # end
  #
  # defp group(list, filename, flags) do
  #   cond do
  #     "-l" in flags -> if (Enum.count(list) > 0), do: filename, else: []
  #     true          -> list
  #   end
  # end
  #
  # defp filter(pattern, flags) do
  #   fn ({line, _number}) ->
  #     cond do
  #       "-v" in flags -> !match_pattern(line, pattern, flags)
  #       true          ->  match_pattern(line, pattern, flags)
  #     end
  #   end
  # end
  #
  # defp match_pattern(line, pattern, flags) do
  #   {subject, matcher} = cond do
  #     "-i" in flags -> {String.downcase(line), String.downcase(pattern)}
  #     true          -> {line, pattern}
  #   end
  #
  #   cond do
  #     "-x" in flags -> subject == matcher
  #     true          -> String.contains?(subject, matcher)
  #   end
  # end
end
