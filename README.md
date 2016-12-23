# ExClearbit

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
```

## TODO

1. A test suite
2. An interface for the streaming API
3. A way to manage callbacks for asynchronous calls
4. Other endpoints besides the Enrichment API

## CONTRIBUTING

1. Fork the repo.
2. Make your changes on a separate branch from master (always keep your master branch
   up to date with the upstream repository).
3. Submit a PR from your changed branch.
