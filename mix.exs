defmodule BattleStandard.MixProject do
  use Mix.Project

  @name :battle_standard
  @version "0.5.0"
  @scm_url "https://github.com/bdanklin/battle_standard"
  @doc_url "https://hexdocs.pm/battle_standard/"

  def project do
    [
      app: :battle_standard,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      name: "Battle Standard",
      source_url: @scm_url,
      homepage_url: @doc_url,
      deps: deps()
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}"
    ]
  end

  def package do
    [
      name: @name,
      licenses: ["MIT"],
      maintainers: ["Benjamin Danklin"],
      links: %{
        "GitHub" => @scm_url
      },
      files: ~w(lib mix.exs README.md .formatter.exs)
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
      {:ex_doc, "~> 0.15", only: :dev},
      {:dialyxir, "~> 1.1", only: :dev, runtime: false}
    ]
  end
end
