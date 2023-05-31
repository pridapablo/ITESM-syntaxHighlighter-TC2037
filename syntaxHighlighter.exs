defmodule Syntax do
  @doc """
  Reads a Python file line by line (using a stream), highlights its syntax and outputs an HTML file
  with highlighted syntax.
  """
  def highlight(file) do
    expanded_path = Path.expand(file)

    IO.puts("Current directory: #{File.cwd!()}")
    IO.puts("Reading file: #{expanded_path}")

    stream = File.stream!(expanded_path)

    # Using a stream to avoid reading the whole file into memory
    highlighted_lines_stream =
      stream
      |> Stream.map(&String.trim_trailing/1)
      |> Stream.map(&helperFun/1)

    {:ok, file} = File.open("06_FinalProject/example.html", [:write])

    IO.write(file, parse_html_header())

    highlighted_lines_stream
    |> Enum.each(fn line ->
      IO.write(file, line <> "\n")
    end)

    IO.write(file, parse_html_footer())

    File.close(file)
  end

  defp highlight_line(line, lst) do
    # Helper function to highlight a line of Python code using regex and output HTML. Issues:
    # - "/" and "=" is matching escaped characters, so it is not an operator currently.
    # - keyword "class" is not implemented because it will match "class" in the html tag.
    # - Multiline strings don't seem to work.

    IO.inspect(lst)

    Enum.reduce(lst, line, fn element, acc ->
      new_line =
        case element do
          "string" ->
            if not Regex.match?(~r/(?<=<span)=/, acc) do
              acc = Regex.replace(~r/("[^"]*")/, acc, "<span class=\"string\">\\1</span>")
              acc = Regex.replace(~r/('[^']*')/, acc, "<span class=\"string\">\\1</span>")
              acc
            end

          "comment" ->
            acc = Regex.replace(~r/#(.*)$/, acc, "<span class=\"comment\">#\\1</span>")
            acc

          "parenthesis" ->
            acc = Regex.replace(~r/(\(|\))/, acc, "<span class=\"parenthesis\">\\1</span>")
            acc = Regex.replace(~r/\b(\w+)\(/, acc, "<span class=\"function\">\\1</span>")
            acc

          "number" ->
            acc = Regex.replace(~r/(\d+)/, acc, "<span class=\"number\">\\1</span>")
            acc

          "operator" ->
            acc = Regex.replace(~r/(\+|\-|\*)/, acc, "<span class=\"operator\">\\1</span>")
            acc

          "boolean" ->
            acc = Regex.replace(~r/\b(True|False)\b/, acc, "<span class=\"boolean\">\\1</span>")
            acc

          "method" ->
            acc = Regex.replace(~r/\.(\w+)/, acc, ".<span class=\"method\">\\1</span>")
            acc

          "keyword" ->
            acc =
              Regex.replace(
                ~r/\b(def|if|else|elif|for|while|in|return)\b/,
                acc,
                "<span class=\"keyword\">\\1</span>"
              )

            acc

          "decorator" ->
            acc = Regex.replace(~r/@(\w+)/, acc, "@<span class=\"decorator\">\\1</span>")
            acc
        end

      new_line
    end)
  end

  defp helperFun(line) do
    # Helper function to run the line highlighter with the list of character types that the line
    # contains (as determined by the charDetector function).
    highlight_line(line, Enum.uniq(charDetector(String.graphemes(line <> " "), [], "")))
  end

  defp charDetector([head | tail], list, status) do
    # Function to detect the type of each character in a line of Python code to only run the
    # relevant regex on the line. This is to avoid running all regex on every line.
    if tail == [] do
      if Enum.member?(list, "string") do
        ["string" | list]
      else
        list
      end
    else
      case head do
        a when status == "string" ->
          if status == "string" && a in ["\"", "\'"] do
            charDetector(tail, ["string" | list], "")
          else
            charDetector(tail, list, "string")
          end

        a when a in ["\"", "\'"] ->
          if status == "string" && a in ["\"", "\'"] do
            charDetector(tail, ["string" | list], "")
          else
            charDetector(tail, list, "string")
          end

        a when a in ["{", "}", "(", ")", "[", "]"] ->
          charDetector(tail, ["parenthesis" | list], "")

        "#" ->
          charDetector([" "], ["comment" | list], "")

        a when a in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] ->
          charDetector(tail, ["number" | list], "")

        a when a in [":", ",", ";", "+", "-", "*", "/", "%", "^"] ->
          charDetector(tail, ["operator" | list], "")

        "@" ->
          charDetector(tail, ["decorator" | list], "")

        "." ->
          if status != "" do
            charDetector(tail, ["method" | list], "")
          end

        a when status in ["true", "false"] ->
          charDetector(tail, ["boolean" | list], "")

        a when status in ["def", "if", "else", "elif", "for", "while", "in", "return"] ->
          charDetector(tail, ["keyword" | list], "")

        " " ->
          charDetector(tail, list, "")

        _ ->
          charDetector(tail, list, status <> head)
      end
    end
  end

  defp parse_html_header() do
    # Helper function to construct the header of the HTML file. This is the part that contains the
    # CSS styles. It is called once at the beginning of the program.
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Syntax Highlighter</title>
        <style>
            .string { color: green; }
            .comment { color: gray; }
            .keyword { color: blue; }
            .number { color: purple; }
            .operator { color: red; }
            .boolean { color: orange; }
            .function { color: brown; }
            .parenthesis { color: brown; }
            .method { color: brown; }
            .decorator { color: grey; }
        </style>
    </head>
    <body>
    <pre>
    """
  end

  defp parse_html_footer() do
    # Helper function to construct the HTML footer. Called after the code has been highlighted.
    """
    </pre>
    </body>
    </html>
    """
  end
end

Syntax.highlight("example1_OOP.py")
Syntax.highlight("example2_Procedural.py")
Syntax.highlight("example3_Functional.py")
