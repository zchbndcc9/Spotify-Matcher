defmodule ServerWeb.ArtistController do
  use ServerWeb, :controller

  def similar(conn, %{"id" => id}) do
    artists = case Spotify.Artist.get_related_artists(conn, id) do
      {:ok, artists} -> artists
    end

    artist = artists |> Enum.random

    conn
    |> render(ServerWeb.ArtistsView, "show.json", %{"artist" => artist})
  end
end
