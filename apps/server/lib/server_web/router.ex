defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug SpotifyAPI.Auth.Plug
  end

  scope "/", ServerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/authorize", SpotifyAuthController, :authorize
    get "/authenticate", SpotifyAuthController, :authenticate
  end

  scope "/api", ServerWeb do
    pipe_through :api

    delete "/playlists/:id", PlaylistController, :delete
    post "/playlists", PlaylistController, :create
    get "/top-artists", UserController, :index
    get "/artists/:id/similar", ArtistController, :similar
  end
end
