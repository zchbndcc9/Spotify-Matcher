defmodule ArtistManager.Store.Impl do
  alias ArtistManager.Store.Impl
  defstruct(
    picked_artists: MapSet.new(),
    artists_showing: MapSet.new()
  )

  def pick_artist(%Impl{ picked_artists: picked, artists_showing: showing }, artist) do
    showing = showing |> MapSet.delete(artist)

    picked = picked |> MapSet.put(artist)

    %Impl{ picked_artists: picked, artists_showing: showing }
  end

  def add_shown_artist(store = %Impl{ artists_showing: showing }, artist) do
    %Impl{ store | artists_showing: showing |> MapSet.put(artist)}
  end
end
