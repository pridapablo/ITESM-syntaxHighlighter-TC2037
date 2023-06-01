# OnePager.md

## Reflections on the Solution, Algorithms, and Execution Time

This Elixir program is designed to provide syntax highlighting for Python files.
It reads a Python file line by line using streams, identifies various language
constructs, and outputs an HTML file with the syntax highlighted.

Reflecting on the proposed solution, we can see that it is a good starting point
for a syntax highlighter. It is a simple solution that uses many of the pros of
using a functional programming language such as Elixir (stream, pattern
matching, etc.). It is important to note that the highlighter is not a full
parser and that that is its main limitation, since it doesn't handle language
rules such as variable names. Regarding other limitations, we could talk about
multiline comments, which are not supported by the highlighter, since its nature
is to read the file line by line.

The execution time of the algorithm is largely determined by the size of the
Python file being processed, but the worst case scenario would mean going
through each line of code quite a few times (1 for the DFA and 12 for all
Regex). However, because the processing is stream-based, it has a small memory
footprint and can handle large files effectively.

Given the previous reflections, we estimate that the code will have a time
complexity of O(n\*m), where n is the number of lines in the Python file and m
is the number of characters in each line. Nevertheless, we are quite confident
that the complexity does not exceed O(n^n), since the algorithm does not have
any nested loops or recursions.

## Algorithm Complexity

### Computational Model

Assuming the following big-O time complexities for the main operations in the
algorithm (based on the [Elixir documentation](https://hexdocs.pm/elixir/)):

| Operation                | Time Complexity |
| ------------------------ | --------------- |
| `File.stream!/1`         | O(n)            |
| `Stream.map/2`           | O(n\*m)         |
| `File.open/2`            | O(1)            |
| `IO.write/2`             | O(n\*m)         |
| `File.close/1`           | O(1)            |
| `String.trim_trailing/1` | O(m)            |
| `Enum.reduce/3`          | O(k\*m)         |
| `Enum.uniq/1`            | O(k)            |
| `Regex.match?/2`         | O(m)            |
| `Regex.replace/3`        | O(m)            |
| `Enum.member?/2`         | O(k)            |
| `String.graphemes/1`     | O(m)            |
| `Path.expand/1`          | O(1)            |
| `Path.basename/2`        | O(1)            |
| `IO.puts/2`              | O(1)            |

We can then analyze each step of the algorithm to determine its complexity:

### Algorithm Analysis

- The main function (highlight/1) is very efficient in terms of memory usage, as
  it uses streams to process the file line by line. Its time complexity is
  O(n\*m), since it is calling the highlight_line/2 function for each line
  (through the wrapper helper function helperFun/1 which has a negligible time
  complexity).

- The highlight_line/2 uses Enum.reduce in conjunction with Regex.replace to
  highlight the input line based on the list of language constructs detected by
  the DFA (charDetector/3). The time complexity of this function is O(k\*m),
  where k is the length of the list of detected tokens and m is the length of
  the line being processed.

- The charDetector/3 iterates recursively through the input line, character by
  character (complexity O(m)) to identify the language constructs.

- All other functions have a time complexity of O(1), since they are used to
  construct the output HTML with predetermined strings.

### Time Complexity Summary

| Function              | Description                                                       | Time Complexity |
| --------------------- | ----------------------------------------------------------------- | --------------- |
| `highlight/1`         | Reads file, highlights syntax, outputs HTML file                  | O(n\*m)         |
| `highlight_line/2`    | Highlights input line based on language constructs detection      | O(k\*m)         |
| `charDetector/3`      | Iterates through input line to identify language constructs       | O(m)            |
| `helperFun/1`         | Wraps `highlight_line/2`, passing line and unique character types | O(1)            |
| `parse_html_header/0` | Constructs the header of the output HTML                          | O(1)            |
| `parse_html_footer/0` | Constructs the footer of the output HTML                          | O(1)            |

## Conclusions and Ethical Reflections

To develop this activity, we constantly embraced the mentality of the functional
programming paradigm to find the most direct way to execute our code. This
process wasn't easy at first since we were mostly oriented towards imperative
programming. Nevertheless, once we understood the idea behind this paradigm, we
discovered a great way to optimize our code.

Initially, we had a code that used a succession of Regex.replace/3 functions to
substitute elements. This approach worked, but when we analyzed its complexity,
it seemed quite high. For this reason, instead of relying on multiple regex
replace functions, we leveraged the concept of Deterministic Finite Automaton
(DFA) to construct a helper function. This function allowed us to selectively
run the necessary replace functions based on each input line. As a result, we
were able to reduce the complexity of the code and make it more efficient.

Efficiency became a focal point throughout the development process. We
understood the importance of writing code that performs optimally, especially
when it needs to handle real-time processing or iterations. Our journey in this
project exposed us to the advantages and tools of functional programming. We
learned to think in terms of parameters and responses, which helped us develop
more modular code that optimizes storage management. Even for future projects
outside the functional paradigm, we plan to implement solutions based on the
recursive and modular thinking that we learned from this project.

From an ethical standpoint, this program does not present major ethical issues,
as it does not involve personal data or decision-making that could have
significant impacts on individuals or society. However, like any software, it
should be used responsibly. The code should be maintained to ensure its accuracy
and reliability, and users should be made aware of any limitations.

Furthermore, are many advantages to using a system that is able to modify the
colors of the text, but the most important is that it allows the user to have a
better experience when reading the text. This not only helps a developer to have
a better experience when reading and writing code, but it could also help people
that suffer the several conditions such as dyslexia, color blindness, and other
visual impairments. This kind of project allows us to understand how such a
"simple" idea can have a huge impact in the world. Furthermore, by deciding to
use a language that is commonly used for learning the basics of code, we could
utilize this system, to some degree, for educational purposes. Such as oriented
new students in their first steps in the world of programming, by providing a
tool that allows them to read, organize and comprehend their codes in a more
factual way.

Moreover, this reflects on a broader ethical consideration about technology
development. As we continue to develop tools that automate processes, it is
critical to assess the potential implications it may have, such as job
displacement, and consider measures to mitigate potential negative impacts.
