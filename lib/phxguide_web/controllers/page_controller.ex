defmodule PhxguideWeb.PageController do
  use PhxguideWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
