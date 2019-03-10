defmodule PhxguideWeb.FakeAuthorizerPlug do
  use PhxguideWeb, :controller
  import Plug.Conn
  alias PhxguideWeb.ErrorView

  def init(opts), do: opts

  def call(conn, opts) do
    conn
    |> put_status(403)
    |> put_view(ErrorView)
    |> render(:"403")
    |> halt()
  end
end
