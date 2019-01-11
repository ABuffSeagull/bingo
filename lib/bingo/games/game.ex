defmodule Bingo.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset


  schema "games" do
    field :name, :string
    field :objectives, :map

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :objectives])
    |> validate_required([:name, :objectives])
    |> unique_constraint(:name)
  end
end
