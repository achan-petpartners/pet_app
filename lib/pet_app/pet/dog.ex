defmodule PetApp.Pet.Dog do
  use Ecto.Schema
  import Ecto.Changeset
  alias PetApp.Pet.Dog


  schema "dogs" do
    field :age, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Dog{} = dog, attrs) do
    dog
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
