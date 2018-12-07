defmodule ArtistLibrary do
  defdelegate checkin_artist(artist), to: ArtistLibrary.Librarian
  defdelegate checkout_sim_artists(artist), to: ArtistLibrary.Librarian
  defdelegate exchange_artist(artist), to: ArtistLibrary.Librarian
end
