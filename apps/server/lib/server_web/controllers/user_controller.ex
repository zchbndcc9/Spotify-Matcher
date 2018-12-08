defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  def index(conn, _params) do
    artists = case Spotify.Personalization.top_artists(conn) do
      {:ok, %Paging{items: artists}} -> artists
      {:ok, %{"error" => message}} -> message
    end

    conn
    |> render(ServerWeb.ArtistsView, "index.json", %{"artists" => artists})
  end
end
