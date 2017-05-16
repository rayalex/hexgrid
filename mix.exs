defmodule Hex.Mixfile do
  use Mix.Project

  def project do
    [app: :hexgrid,
     version: "2.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     package: package()]
  end

  def application do
    []
  end

  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev}]
  end

  defp description do
    """
    Create Hexagonal grids and Maps. Useful if you're building Hex-based games.
    """
  end

  defp package do
    [
      name: :hexgrid,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Aleksandar Dragojevic"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/rayalex/hex"}
    ]
  end
end
