defmodule Server.SpotifyAPI.RaiseFlags do
  import Plug.Conn

  def init(default), do: default

  def raise_token_flags(flags, conn) do
    flags
    |> Map.put(:tokens_present?, Spotify.Authentication.tokens_present?(conn))
  end

  def raise_authentication_flags(flags = %{tokens_present?: false}, _conn, _params) do
    flags
  end

  def raise_authentication_flags(flags, conn, code = %{"code" => _valid_code}) do
    case Spotify.Authentication.authenticate(conn, code) do
      {:ok, _conn} -> Map.put(flags, :authenticated?, true)
      {:error, _conn} -> Map.put(flags, :authenticated?, false)
    end
  end

  def raise_authentication_flags(flags, _conn, _) do
    flags
    |> Map.put(:authenticated?, false)
  end

  defp _assign_flags(_flags, [], conn) do
    conn
  end

  defp _assign_flags(flags, [flag | t], conn) do
    status = flags |> Map.get(flag)
    _assign_flags(flags, t, assign(conn, flag, status))
  end

  def assign_flags(flags, conn) do
    _assign_flags(flags, Map.keys(flags), conn)
  end

  def call(conn, params) do
    Map.new()
    |> raise_token_flags(conn)
    |> raise_authentication_flags(conn, params)
    |> assign_flags(conn)
  end
end

defmodule Server.SpotifyAPI do
  def get_artists(conn) do
    {_status, %Paging{items: artists}} = conn
    |> Spotify.Personalization.top_artists

    artists
  end
end
