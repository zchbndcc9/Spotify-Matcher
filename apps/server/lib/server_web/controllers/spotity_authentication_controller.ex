defmodule ServerWeb.SpotifyAuthController do
  use ServerWeb, :controller

  def authorize(conn, _params) do
    redirect conn, external: Spotify.Authorization.url
  end

  def authenticate(conn, params) do
    Spotify.Authentication.authenticate(conn, params)
  end
end
