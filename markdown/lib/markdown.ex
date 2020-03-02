defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    # Replace lines with paragraphs
    |> String.replace(~r/^([^#\*]{1}.+)$/, "<p>\\1</p>")
    # Replace Headers
    |> String.replace(~r/[#]{6} (.+)/, "<h6>\\1</h6>")
    |> String.replace(~r/[#]{5} (.+)/, "<h5>\\1</h5>")
    |> String.replace(~r/[#]{4} (.+)/, "<h4>\\1</h4>")
    |> String.replace(~r/[#]{3} (.+)/, "<h3>\\1</h3>")
    |> String.replace(~r/[#]{2} (.+)/, "<h2>\\1</h2>")
    |> String.replace(~r/[#]{1} (.+)/, "<h1>\\1</h1>")
    # Replace Bold
    |> String.replace(~r/__(.+)__/, "<strong>\\1</strong>")
    # Replace Italic
    |> String.replace(~r/_(.+)_/, "<em>\\1</em>")
    # Replace list content
    |> String.replace(~r/\* (.+)/, "<li>\\1</li>")
    # Group list items into lists
    |> String.replace(~r/(<li>(.+)(\n<li>.+)*<\/li>)/, "<ul>\\1</ul>")
    # Remove new lines
    |> String.replace("\n", "")
  end
end
