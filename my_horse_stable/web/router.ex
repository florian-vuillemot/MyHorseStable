defmodule MyHorseStable.Router do
  use MyHorseStable.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyHorseStable do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
    resources "/horse_race", HorseRaceController
    resources "/customers", CustomerController
    resources "/horses", HorseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyHorseStable do
  #   pipe_through :api
  # end
end
