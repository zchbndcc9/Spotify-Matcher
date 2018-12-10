defmodule PlaylistBuilder.Playlist do
  @enforce_keys [:conn, :user_id]
  defstruct(
    user_id: "",
    conn: %Plug.Conn{},
    id: "",
    uri: "",
    title: "",
    description: "",
    artists: [],
    songs: [],
    song_limit: 10
  )
end
