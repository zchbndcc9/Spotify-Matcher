defmodule ArtistManager do
  defdelegate add(artist), to: ArtistManager.Store
  defdelegate get_all(), to: ArtistManager.Store
  defdelegate add_and_get(artist), to: ArtistManager.Store
  defdelegate contains?(artist), to: ArtistManager.Store
  defdelegate update_similar_artists(artist, similar_artists), to: ArtistManager.Store
  defdelegate get_similar_artists(artist), to: ArtistManager.Store
  defdelegate similar_artists?(artist), to: ArtistManager.Store
end
