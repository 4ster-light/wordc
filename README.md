# wordc
- A command-line tool to count words, lines, and characters in a file.
- Similar to the `wc` command in Unix.

## Usage
> [!IMPORTANT]
> This tool requires the `haskell` build system to build it locally.

In order to build the project, run the following command:
``` bash
cabal build
```
Then to run the tool, run the following command:
``` bash
cabal run wordc <filename>
```

## Example
``` bash
cabal run wordc -- ./README.md -s a
Lines: 25
Words: 91
Chars: 499
Search occurrences: 15
```