defmodule ExClearbit.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_clearbit,
     version: "0.1.3",
     name: "ExClearbit",
     elixir: "~> 1.5",
     description: description(),
     package: package(),
     docs: [main: "ExClearbit",
            extras: ["README.md"],
            source_url: "https://github.com/keithmattix/github"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :exconstructor],
     mod: {ExClearbit, []}]
  end

  defp description do
    "A lightweight API client for Clearbit"
  end

  defp package do
    [maintainers: ["Keith Mattix II"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/keithmattix/ex_clearbit"}]
  end

  defp deps do
    [{:httpoison, "~> 1.0"},
     {:credo, "~> 0.8", only: [:dev, :test]},
     {:poison, "~> 3.0"},
     {:exconstructor, "~> 1.1"},
     {:ex_doc, "~> 0.18", only: [:dev]}]
  end
end
