defmodule ServerWeb.ArtistMangerChannel do
  use Phoenix.Channel

  def join("app:artists", _message, socket) do
    {:ok, socket}
  end

  def add("app:artists", artist, socket) do
    ArtistManager.add(artist)
    {:noreply, socket}
  end
end
