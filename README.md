# syntaxHighlighter

Syntax Highlighter for Python (Written in Elixir)

Authored by:

- Pablo Banzo Prida
- Gabriel Rodriguez de los Reyes

Instructor for TC2037 (ITESM Course): Gilberto Echeverría Furió

## Live demo

https://pridapablo.github.io/ITESM-syntaxHighlighter-TC2037/

## About

This repository contains an Elixir program that reads a Python file, highlights its syntax, and outputs an HTML file with the highlighted syntax. The syntax highlighter recognizes Python language constructs such as strings, comments, keywords, numbers, operators, booleans, functions, parentheses, methods, and decorators.

## Prerequisites

- Elixir installed on your machine.

## Elixir Installation

Please refer to the official [Elixir Installation Guide](https://elixir-lang.org/install.html) to set up Elixir on your machine.

## Run locally

1. Clone this repository and enter it.

```bash
git clone https://github.com/pridapablo/ITESM-syntaxHighlighter-TC2037.git
cd ITESM-syntaxHighlighter-TC2037
```

2. Start an `iex` session with the highlighter module loaded.

```bash
iex syntaxHighlighter_V1.exs
```

3. Highlight a Python file from inside the `iex` session.

```elixir
Syntax.highlight("PythonFiles/example1_OOP.py")
```

The output is written to `highlighted_code/<name>.html` (the `highlighted_code/` directory must exist in the directory you run from). Open that file in a browser.

Three sample files are in `PythonFiles/`:

- example1_OOP.py
- example2_Procedural.py
- example3_Functional.py

The pages in `docs/samples/` (served by the live demo) are the highlighter's output for those three files.

## One Pager Analysis

There is a OnePager.md file at the root of this repository. It contains:

- Reflections on the proposed solution, the implemented algorithms, and the execution time of these algorithms.

- Calculation of the algorithm's complexity based on the number of iterations and comparison with the estimated time mentioned above.

- Conclusions drawn from the reflections in points 1 and 2. It also includes a brief reflection on the ethical implications that the type of technology developed here could have on society.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
