# Htc

Takes a triangle in the form of a list of lists of numbers, turns it into a binary tree and returns the sum of elements.
Input is considered to be a triangle if each successive layer has one more element than the previous.

## Why Elixir?

The task description puts Correctness and Readability as priorities. Elixir's Erlang's heritage makes it natural to write fail-proof code and it's Ruby-like syntax and pattern matching makes it easy to write readable code.

## Installation

Requires Elixir 1.2 or later.

[Install Elixir](https://elixir-lang.org/install.html)

It can also be installed as a library in your existing project:

```elixir
def deps do
  [{:htc, git: "https://github.com/erikdsi/htc"}]
end
```

## Usage

Clone the repo and enter the directory:
```bash
$ git clone https://github.com/erikdsi/htc
$ cd htc
```
Run tests:
```bash
$ mix test
```
Or play with it in IEx(Elixir's REPL):
```bash
$ iex -S mix
iex> Htc.max_sum [[6],[3,5],[9,7,1],[4,6,8,4]]
{:ok, 26}
iex> Htc.max_sum! [[6],[3,5],[9,7,1],[4,6,8,4]]
26
```
`Htc.max_sum` returns a tagged tuple which can be either `{:ok, result}` or `{:error, error_string}`.
`Htc.max_sum!` will either return the result or throw an error.

The tagged tuples idiom is an Elixir idiom inherited from Erlang which makes it easy to deal with errors in a clean and controlled way.