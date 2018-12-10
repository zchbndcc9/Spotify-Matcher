defmodule PlaylistBuilder do
  alias PlaylistBuilder.Playlist

  def build(conn) do
    conn
    |> create()
    |> build_song_list()
    |> pick_songs()
    |> replace_songs_with_uris()
    |> add_songs()
    |> extract_uri()
  end

  def create(conn = %Plug.Conn{ params: %{"user_id" => user_id, "picked_artists" => artists, "title" => title, "song_limit" => song_limit }}) do
    body = "{\"name\": \"#{title}\"}"
    {playlist_id, uri} = case Spotify.Playlist.create_playlist(conn, user_id, body) do
      {:ok, %Spotify.Playlist{id: id, uri: uri }} -> {id, uri}
    end

    %Playlist{
      conn: conn,
      user_id: user_id,
      id: playlist_id,
      uri: uri,
      title: title,
      artists: artists,
      song_limit: song_limit
    }
  end


  def build_song_list(details = %Playlist{}) do
    details
    |> get_artist_recommendations()
    |> get_song_recommendations()
  end

  def get_artist_recommendations(details = %Playlist{ conn: conn, artists: artists }) do
    artist_recs = artists
    |> Enum.map(fn %{"id" => id} -> Task.async(fn -> related_artists(conn, id) end) end)
    |> Enum.flat_map(fn task -> Task.await(task) end)

    %Playlist{ details | artists: artist_recs}
  end

  def get_song_recommendations(details = %Playlist{ conn: conn, artists: artists }) do
    songs = artists
    |> Enum.map(fn %Spotify.Artist{id: id} -> Task.async(fn -> top_tracks(conn, id) end) end)
    |> Enum.flat_map(fn task -> Task.await(task) end)

    %Playlist{ details | songs: songs}
  end

  def pick_songs(details = %Playlist{ songs: songs, song_limit: count }) do
    picked_songs = songs
    |> Enum.to_list
    |> Enum.take_random(count)

    %Playlist{ details | songs: picked_songs }
  end

  def replace_songs_with_uris(details = %Playlist{ songs: songs }) do
    uris = songs
    |> Enum.map(fn %Spotify.Track{uri: uri} -> uri end)

    %Playlist{ details | songs: uris }
  end

  def add_songs(details = %Playlist{ conn: conn, user_id: user_id, id: playlist_id, songs: uris }) do
    body = Poison.encode!(%{uris: uris})
    case Spotify.Playlist.add_tracks(conn, user_id, playlist_id, body, []) do
      {:ok, _} -> details
    end
  end

  defp related_artists(conn, id) do
    case Spotify.Artist.get_related_artists(conn, id) do
      {:ok, artists} -> artists
    end
  end

  defp top_tracks(conn, id) do
    case Spotify.Artist.get_top_tracks(conn, id, country: "US") do
      {:ok, songs} -> songs
    end
  end

  def extract_uri(%Playlist{ uri: uri}) do
    uri
  end
end
