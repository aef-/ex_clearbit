# ExClearbit

Elixir client for [Clearbit](https://clearbit.com).

## Installation

First, add `ExClearbit` to your `mix.exs` file:

```elixir
def deps do
  [{:ex_clearbit, "~> 0.1.0"}]
end
```

then run `$ mix deps.get`. Now add the `:ex_clearbit` application as your application dependency:

```elixir
def application do
  [applications: [:ex_clearbit]]
end
```

## Usage

```iex
iex> ExClearbit.person("alex@alexmaccaw.com")
```

## TODO

1. A test suite
2. An interface for the streaming API
3. A way to manage callbacks for asynchronous calls
