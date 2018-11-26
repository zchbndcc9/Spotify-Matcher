defmodule Server.SpotifyAPI.RaiseFlags do
  import Plug.Conn

  def init(default), do: default

  def raise_token_flags(conn) do
    assign(conn, :tokens_present?,  Spotify.Authentication.tokens_present?(conn))
  end

  def raise_authentication_flags(conn) do
    assign(conn, :authenticated?, Spotify.Authentication.authenticated?(conn))
  end

  def call(conn, _params) do
    conn
    |> raise_token_flags
    |> raise_authentication_flags
  end
end
