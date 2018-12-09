defmodule ArtistManager do
  defdelegate create_store(user_id), to: ArtistManager.StoreSupervisor
  defdelegate add_shown_artist(user_id, artist), to: ArtistManager.Store
  defdelegate get_store(user_id), to: ArtistManager.Store
  defdelegate pick_artist(user_id, artist), to: ArtistManager.Store
end
