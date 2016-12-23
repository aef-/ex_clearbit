defmodule ExClearbit.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_clearbit,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: description,
     package: package,
     docs: [main: "ExClearbit",
            extras: ["README.md"],
            source_url: "https://github.com/adjust/airbax"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     name: "ExClearbit",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :exconstructor],
     mod: {ExClearbit, []}]
  end

  defp description do
    "A light API wrapper for Clearbit"
  end

  defp package do
    [maintainers: ["Keith Mattix II"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/keithmattix/ex_clearbit"}]
  end

  defp deps do
    [{:httpoison, "~> 0.8.0"},
     {:credo, "~> 0.4", only: [:dev, :test]},
     {:poison, "~> 2.0"},
     {:inflex, "~> 1.7.0"},
     {:exconstructor, "~> 1.0.2"}]
  end
end
