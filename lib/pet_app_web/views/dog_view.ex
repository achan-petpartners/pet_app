defmodule PetAppWeb.DogView do
  use PetAppWeb, :view
  alias PetAppWeb.DogView

  def render("index.json", %{dogs: dogs}) do
    %{data: render_many(dogs, DogView, "dog.json")}
  end

  def render("show.json", %{dog: dog}) do
    %{data: render_one(dog, DogView, "dog.json")}
  end

  def render("dog.json", %{dog: dog}) do
    %{id: dog.id,
      name: dog.name,
      age: dog.age}
  end
end
