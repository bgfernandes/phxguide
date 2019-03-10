defmodule PhxguideWeb.PageController do
  use PhxguideWeb, :controller

  action_fallback PhxguideWeb.FallbackController

  plug :assign_welcome_message, "Hi!" when action in [:index]
  plug :assign_welcome_message, "Ho!" when action not in [:index]

  def index(conn, params) do
    conn
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> assign(:name, "Dweezil")
    |> put_status(202)
    |> render(:index, message_two: params["message"])
  end

  def index_no_layout(conn, params) do
    conn
    |> put_layout(false)
    |> index(params)
  end

  def index_adm_layout(conn, params) do
    conn
    |> put_layout("admin.html")
    |> index(params)
  end

  def show_text(conn, %{"id" => id}) do
    text(conn, "Showing id #{id}")
  end

  def show_json(conn, %{"id" => id}) do
    json(conn, %{id: id})
  end

  def show_html(conn, %{"id" => id}) do
    html(conn, """
       <html>
         <head>
            <title>Passing an Id</title>
         </head>
         <body>
           <p>You sent in id #{id}</p>
         </body>
       </html>
      """)
  end

  def show_plain(conn, %{"id" => id}) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(201, "Showing id #{id}")
  end

  def redirect_test(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :index))
  end

  def unauthorized_test(conn, _params) do
    with true <- {:error, :unauthorized} do
      render(conn, :index)
    end
  end

  def not_found_test(conn, _params) do
    with true <- {:error, :not_found} do
      render(conn, :index)
    end
  end

  defp assign_welcome_message(%{halted: true} = conn, _), do: conn

  defp assign_welcome_message(conn, msg) do
    assign(conn, :message, msg)
  end
end
