defmodule ServerWeb.PlaylistsView do
  use ServerWeb, :view

  def render("show.json", %{"playlist_uri" => playlist_uri}) do
    %{
      playlist_uri: playlist_uri
    }
  end
end
