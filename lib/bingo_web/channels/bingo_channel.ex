defmodule BingoWeb.BingoChannel do
  use Phoenix.Channel

  def join("bingo", _message, socket) do
    :rand.seed(:exsplus, {1, 1, 1})
    {:ok, %{"easy" => objectives}} = Toml.decode_file("boi.toml")

    objectives =
      Enum.take_random(objectives, 25)
      |> Enum.map(& &1["name"])

    {:ok, objectives, socket}
  end

  def handle_in("choose", payload, socket) do
    broadcast(socket, "chosen", payload)
    {:noreply, socket}
  end
end
