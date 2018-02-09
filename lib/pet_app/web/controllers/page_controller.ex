defmodule PetApp.Web.PageController do
  use PetApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
