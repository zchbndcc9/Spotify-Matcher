defmodule Playlist do
  alias __MODULE__
  @enforce_keys [:user_id]

  defstruct(
    user_id: "",
    title: "",
    description: "",
    songs: []
  )
  
end
