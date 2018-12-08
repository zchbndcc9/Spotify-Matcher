defmodule ServerWeb.ArtistsView do
  use ServerWeb, :view

  def render("index.json", %{"artists" => artists}) do
    %{
      artists: Enum.map(artists, &artist_json/1)
    }
  end

  def render("show.json", %{"artist" => artist}) do
    %{
      artist: artist |> artist_json()
    }
  end

  def artist_json(artist) do
    %{
      id: artist.id,
      name: artist.name,
      img: artist.images |> List.first()
    }
  end
end

