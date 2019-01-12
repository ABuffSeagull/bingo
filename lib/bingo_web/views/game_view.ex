defmodule BingoWeb.GameView do
  use BingoWeb, :view
  alias BingoWeb.GameView

  def render("index.json", %{games: games}) do
    %{data: render_many(games, GameView, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{id: game.id, name: game.name, objectives: game.objectives}
  end
end
