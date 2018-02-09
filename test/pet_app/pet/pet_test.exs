defmodule PetApp.PetTest do
  use PetApp.DataCase

  alias PetApp.Pet

  describe "dogs" do
    alias PetApp.Pet.Dog

    @valid_attrs %{age: "some age", name: "some name"}
    @update_attrs %{age: "some updated age", name: "some updated name"}
    @invalid_attrs %{age: nil, name: nil}

    def dog_fixture(attrs \\ %{}) do
      {:ok, dog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pet.create_dog()

      dog
    end

    test "list_dogs/0 returns all dogs" do
      dog = dog_fixture()
      assert Pet.list_dogs() == [dog]
    end

    test "get_dog!/1 returns the dog with given id" do
      dog = dog_fixture()
      assert Pet.get_dog!(dog.id) == dog
    end

    test "create_dog/1 with valid data creates a dog" do
      assert {:ok, %Dog{} = dog} = Pet.create_dog(@valid_attrs)
      assert dog.age == "some age"
      assert dog.name == "some name"
    end

    test "create_dog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pet.create_dog(@invalid_attrs)
    end

    test "update_dog/2 with valid data updates the dog" do
      dog = dog_fixture()
      assert {:ok, dog} = Pet.update_dog(dog, @update_attrs)
      assert %Dog{} = dog
      assert dog.age == "some updated age"
      assert dog.name == "some updated name"
    end

    test "update_dog/2 with invalid data returns error changeset" do
      dog = dog_fixture()
      assert {:error, %Ecto.Changeset{}} = Pet.update_dog(dog, @invalid_attrs)
      assert dog == Pet.get_dog!(dog.id)
    end

    test "delete_dog/1 deletes the dog" do
      dog = dog_fixture()
      assert {:ok, %Dog{}} = Pet.delete_dog(dog)
      assert_raise Ecto.NoResultsError, fn -> Pet.get_dog!(dog.id) end
    end

    test "change_dog/1 returns a dog changeset" do
      dog = dog_fixture()
      assert %Ecto.Changeset{} = Pet.change_dog(dog)
    end
  end
end
