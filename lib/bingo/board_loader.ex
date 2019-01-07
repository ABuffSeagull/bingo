defmodule Bingo.BoardLoader do
  use Agent
  require Toml

  def start_link(_opts) do
    {:ok, objectives} = Toml.decode_file("boards/boi.toml")

    Agent.start_link(fn -> %{"boi" => objectives} end, name: __MODULE__)
  end

  def get(game), do: Agent.get(__MODULE__, &Map.get(&1, game))
end
