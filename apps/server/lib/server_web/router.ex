defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SpotifyAPI.Auth.Plug
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

    delete "/playlists/:id", SpotifyAPI.PlaylistController, :delete
    post "/playlists", SpotifyAPI.PlaylistController, :create
    get "/top-artists", SpotifyAPI.UserController, :index
    get "/artists/:id/similar", SpotifyAPI.ArtistController, :index
  end
end
