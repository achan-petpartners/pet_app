defmodule PetAppWeb.DogControllerTest do
  use PetAppWeb.ConnCase

  alias PetApp.Pet
  alias PetApp.Pet.Dog

  @create_attrs %{age: "some age", name: "some name"}
  @update_attrs %{age: "some updated age", name: "some updated name"}
  @invalid_attrs %{age: nil, name: nil}

  def fixture(:dog) do
    {:ok, dog} = Pet.create_dog(@create_attrs)
    dog
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dogs", %{conn: conn} do
      conn = get conn, dog_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create dog" do
    test "renders dog when data is valid", %{conn: conn} do
      conn = post conn, dog_path(conn, :create), dog: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, dog_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "age" => "some age",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, dog_path(conn, :create), dog: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update dog" do
    setup [:create_dog]

    test "renders dog when data is valid", %{conn: conn, dog: %Dog{id: id} = dog} do
      conn = put conn, dog_path(conn, :update, dog), dog: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, dog_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "age" => "some updated age",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, dog: dog} do
      conn = put conn, dog_path(conn, :update, dog), dog: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete dog" do
    setup [:create_dog]

    test "deletes chosen dog", %{conn: conn, dog: dog} do
      conn = delete conn, dog_path(conn, :delete, dog)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, dog_path(conn, :show, dog)
      end
    end
  end

  defp create_dog(_) do
    dog = fixture(:dog)
    {:ok, dog: dog}
  end
end
