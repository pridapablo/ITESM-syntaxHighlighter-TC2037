# syntaxHighlighter

Syntax Highlighter for Python (Written in Elixir)

Authored by:

- Pablo Banzo Prida
- Gabriel Rodriguez de los Reyes

Instructor for TC2037 (ITESM Course): Gilberto Echeverría Furió

## About

This repository contains an Elixir program that reads a Python file, highlights its syntax, and outputs an HTML file with the highlighted syntax. The syntax highlighter recognizes Python language constructs such as strings, comments, keywords, numbers, operators, booleans, functions, parentheses, methods, and decorators.

## Prerequisites

- Elixir installed on your machine.

## Elixir Installation

Please refer to the official [Elixir Installation Guide](https://elixir-lang.org/install.html) to set up Elixir on your machine.

## Installation and Usage

1. Clone this repository to your local machine.

```bash
git clone https://github.com/pridapablo/syntaxHighlighter.git
```

2. Navigate to the repository folder.

```bash
cd syntaxHighlighter
```

3. Run the highlighter module.

```bash
iex syntaxHighlighter.exs
```

4. To highlight a python file, use the following Elixir command in your terminal (while in the iex session):

```elixir
Syntax.highlight("<your-python-file.py>")
```

Replace <your-python-file.py> with the name of the Python file you want to analyze. For example:

```elixir
Syntax.highlight("python_examples/example1_OOP.py")
```

The current repository contains three Python files that you can use to test the syntax highlighter (all three files are in the python_examples/ directory)

- example1_OOP.py
- example2_Procedural.py
- example3_Functional.py

4. The program will create an HTML file in the highlighted_code/ directory with the same base name as your Python file. For example, if your Python file was named example.py, the output file will be highlighted_code/example.html.

5. Open the generated HTML file in your web browser to see the highlighted Python code.

## One Pager Analysis

There is a OnePager.md file at the root of this repository. It contains:

- Reflections on the proposed solution, the implemented algorithms, and the execution time of these algorithms.

- Calculation of the algorithm's complexity based on the number of iterations and comparison with the estimated time mentioned above.

- Conclusions drawn from the reflections in points 1 and 2. It also includes a brief reflection on the ethical implications that the type of technology developed here could have on society.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
