defmodule ServerWeb.PageController do
  use ServerWeb, :controller

  def index(conn, params) do
    artists = case Spotify.Personalization.top_artists(conn, params) do
      {:ok, %Paging{items: artists}} -> artists
      {:ok, %{"error" => message}} -> message
    end

    render(conn, "index.html", artists: artists)
  end
end
