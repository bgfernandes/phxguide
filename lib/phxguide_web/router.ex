defmodule PhxguideWeb.Router do
  use PhxguideWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
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
    get "/hello", HelloController, :index
    get "/hello/:my_param", HelloController, :show

    forward "/jobs", BackgroundJob.Plug, name: "Hello Phoenix"

    scope "/reviews" do
      pipe_through :review_entitlement_checks

      resources "/", ReviewController
    end
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
