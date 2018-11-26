defmodule ServerWeb.SpotifyAuthController do
  use ServerWeb, :controller

  def authenticate(conn, params) do
    case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn} -> redirect conn, to: "/"
    end
  end
end
