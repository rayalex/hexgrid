defmodule Hex.Mixfile do
  use Mix.Project

  def project do
    [app: :hex,
     version: "1.0.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     package: package]
  end

  def application do
    []
  end

  defp deps do
    [{:ex_doc, "~> 0.13.0"}]
  end

  defp description do
    """
    Create Hexagonal grids and Maps. Useful if you're building Hex-based games.
    """
  end

  defp package do
    [
      name: :hexgrid,
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Aleksandar Dragojevic"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/rayalex/hex"}
    ]
  end
end
