defmodule BingoWeb.BingoChannel do
  use BingoWeb, :channel

  def join("bingo:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("bingo:" <> id, _payload, socket) do
	  id = String.to_integer(id)
	  :rand.seed(:exsplus, {id, id, id})
	  {:ok, %{"easy" => objectives}} = Toml.decode_file("boi.toml")

	  objectives =
	  	Enum.take_random(objectives, 25)
	  	|> Enum.map(& &1["name"])
	  {:ok, objectives, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (bingo:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
