defmodule BingoWeb.PageController do
  use BingoWeb, :controller
  require Toml

  def index(conn, _params) do
    # {:ok, %{"easy" => objectives}} = Toml.decode_file("boi.toml")

    # objectives =
    #   Enum.take_random(objectives, 25)
    #   |> Enum.zip(0..24)

    # conn
    # |> assign(:objectives, objectives)
    # |> render("index.html")
    render(conn, "index.html")
  end
end
