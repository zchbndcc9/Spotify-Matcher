defmodule ArtistLibrary.Library.Impl do
  @type artists :: %{String: list(String)}

  @spec add(String, artists()) :: artists()
  def add(artist, artists) do
    artists
    |> Map.put_new(artist, [])
  end

  def update_similar_artists(_artist, [], artists) do
    artists
  end

  @spec update_similar_artists(String, list(String), artists()) :: artists()
  def update_similar_artists(artist, similar_artists, artists) do
    artists
    |> Map.replace!(artist, similar_artists)
  end


  @spec similar_artists?(String, artists()) :: boolean()
  def similar_artists?(artist, artists) do
    artists
    |> Map.get(artist)
    |> Enum.empty?()
  end

  @spec get_similar_artists(String, artists()) :: list(String)
  def get_similar_artists(artist, artists) do
    artists
    |> Map.get(artist)
  end

  @spec contains?(String, artists()) :: boolean()
  def contains?(artist, artists) do
    artists
    |> Map.has_key?(artist)
  end
end
