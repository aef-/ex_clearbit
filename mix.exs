defmodule ExClearbit.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_clearbit,
      version: "0.2.3",
      name: "ExClearbit",
      elixir: "~> 1.13",
      description: description(),
      package: package(),
      docs: [
        main: "ExClearbit",
        extras: ["README.md"],
        source_url: "https://github.com/keithmattix/github"
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :exconstructor, :poison], mod: {ExClearbit, []}]
  end

  defp description do
    "A lightweight API client for Clearbit"
  end

  defp package do
    [
      maintainers: ["Keith Mattix II"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/keithmattix/ex_clearbit"}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.3"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:poison, "~> 4.0"},
      {:exconstructor, "~> 1.1"},
      {:ex_doc, "~> 0.19", only: [:dev]}
    ]
  end
end
