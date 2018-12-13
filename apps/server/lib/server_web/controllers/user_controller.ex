defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  def index(conn, _params) do
    {:ok, %Spotify.Profile{ id: id }} = Spotify.Profile.me(conn)
    artists = case Spotify.Personalization.top_artists(conn) do
      {:ok, %Paging{items: artists}} -> artists
      {:ok, %{"error" => message}} -> message
    end

    artists
    |> Enum.map(fn %Spotify.Artist{ id: id} -> id end)
    |> Enum.each(fn artist -> ArtistManager.add_shown_artist(id, artist) end)

    conn
    |> render(ServerWeb.ArtistsView, "index.json", %{"artists" => artists})
  end
end
