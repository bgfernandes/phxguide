defmodule PhxguideWeb.Router do
  use PhxguideWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhxguideWeb.Plugs.Locale, "en"
  end

  pipeline :review_entitlement_checks do
    # nothing, yet
  end

  pipeline :admin do
    # nothing, yet
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxguideWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/nolayout", PageController, :index_no_layout
    get "/admlayout", PageController, :index_adm_layout
    get "/text/:id", PageController, :show_text
    get "/json/:id", PageController, :show_json
    get "/html/:id", PageController, :show_html
    get "/plain/:id", PageController, :show_plain

    get "/hello", HelloController, :index
    get "/hello/:my_param", HelloController, :show

    forward "/jobs", Plugs.BackgroundJob, name: "Hello Phoenix"

    scope "/reviews" do
      pipe_through :review_entitlement_checks

      resources "/", ReviewController
    end

    get "/redirect_test", PageController, :redirect_test
    get "/unauthorized", PageController, :unauthorized_test
    get "/notfound", PageController, :not_found_test
  end

  scope "/fakeauth", PhxguideWeb do
    pipe_through [:browser, PhxguideWeb.FakeAuthorizerPlug]
    get "/", PageController, :index
  end

  scope "/admin", PhxguideWeb.Admin, as: :admin do
    pipe_through [:browser, :admin]
    resources "/reviews", ReviewController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxguideWeb do
  #   pipe_through :api
  # end
end
