defmodule ServerWeb.PageController do
  use ServerWeb, :controller

  def index(conn, _params) do
    {:ok, %Spotify.Profile{ id: id }} = Spotify.Profile.me(conn)
    ArtistManager.restart_store(id)
    render(conn, "app.html")
  end
end
