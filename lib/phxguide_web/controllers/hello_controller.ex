defmodule PhxguideWeb.HelloController do
  use PhxguideWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"my_param" => my_param}) do
    render(conn, "show.html", my_param: my_param)
  end
end
