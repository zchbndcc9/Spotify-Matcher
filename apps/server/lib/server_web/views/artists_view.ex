defmodule ServerWeb.ArtistsView do
  use ServerWeb, :view

  def render("index.json", %{"arists" => artists}) do
    %{
      artists: Enum.map(artists, &artist_json/1)
    }
  end

  def artist_json(artist) do
    %{
      id: artist.user_id,
      name: artist.name,
      img: artist.img
    }
  end
end

