# ExClearbit

[![Elixir CI](https://github.com/aef-/ex_clearbit/actions/workflows/elixir.yml/badge.svg)](https://github.com/aef-/ex_clearbit/actions/workflows/elixir.yml)
[![Module Version](https://img.shields.io/hexpm/v/ex_clearbit.svg)](https://hex.pm/packages/ex_clearbit)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ex_clearbit/)
[![Total Download](https://img.shields.io/hexpm/dt/ex_clearbit.svg)](https://hex.pm/packages/ex_clearbit)
[![License](https://img.shields.io/hexpm/l/ex_clearbit.svg)](https://github.com/aef-/ex_clearbit/blob/main/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/aef-/ex_clearbit.svg)](https://github.com/aef-/ex_clearbit/commits/main)

A lightweight Elixir client for [Clearbit](https://clearbit.com).

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

Before calling the API methods, add your API key to your `config.exs` file:
```elixir
config :ex_clearbit, :config,
  api_key: "YOUR_API_KEY"
```

or, you can configure the client at runtime:
```elixir
ExClearbit.configure(api_key: "YOUR API_KEY")
```

## Usage

```iex
iex> ExClearbit.person("alex@alexmaccaw.com")
