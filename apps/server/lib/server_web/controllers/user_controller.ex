defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  def index(conn, _params) do
    case Spotify.Personalization.top_artists(conn) do
      {:ok, %Paging{items: artists}} -> artists
      {:ok, %{"error" => message}} -> message
    end
  end
end
