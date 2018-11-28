defmodule ServerWeb.ArtistLibraryChannel do
  use Phoenix.Channel

  def join("app:artists", _message, socket) do
    {:ok, socket}
  end

  def handle_in("add", artist, socket) do
    ArtistLibrary.add(artist)
    {:noreply, socket}
  end
end
