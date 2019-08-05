defmodule HamRadio.MixProject do
  use Mix.Project

  def project do
    [
      app: :ham_radio,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Package Information
      name: "HamRadio",
      source_url: "https://github.com/hamhub/ham_radio_ex",
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description() do
    "A general purpose library of amateur radio utilities and types."
  end

  defp package() do
    [
      name: "ham_radio",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/hamhub/ham_radio_ex"}
    ]
  end
end
