defmodule PetAppWeb.DogController do
  use PetAppWeb, :controller

  alias PetApp.Pet
  alias PetApp.Pet.Dog

  action_fallback PetAppWeb.FallbackController

  def index(conn, _params) do
    dogs = Pet.list_dogs()
    render(conn, "index.json", dogs: dogs)
  end

  def create(conn, %{"dog" => dog_params}) do
    with {:ok, %Dog{} = dog} <- Pet.create_dog(dog_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", dog_path(conn, :show, dog))
      |> render("show.json", dog: dog)
    end
  end

  def show(conn, %{"id" => id}) do
    dog = Pet.get_dog!(id)
    render(conn, "show.json", dog: dog)
  end

  def update(conn, %{"id" => id, "dog" => dog_params}) do
    dog = Pet.get_dog!(id)

    with {:ok, %Dog{} = dog} <- Pet.update_dog(dog, dog_params) do
      render(conn, "show.json", dog: dog)
    end
  end

  def delete(conn, %{"id" => id}) do
    dog = Pet.get_dog!(id)
    with {:ok, %Dog{}} <- Pet.delete_dog(dog) do
      send_resp(conn, :no_content, "")
    end
  end
end
