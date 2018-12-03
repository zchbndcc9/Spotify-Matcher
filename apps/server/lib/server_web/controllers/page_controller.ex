defmodule ServerWeb.PageController do
  use ServerWeb, :controller

  plug :authorize
  plug :authenticate

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  defp authorize(conn, _) do
    case Spotify.Authentication.tokens_present?(conn) do
      {:ok, conn} -> conn
      {:error, _} ->
        conn
        |> render("new_user.html")
        |> halt()
    end
  end

  defp authenticate(conn, _) do
    case Spotify.Authentication.authenticated?(conn) do
      {:ok, conn} ->
        conn
        |> halt()
      {:error, _} ->
        conn
        |> refresh_tokens()
    end
  end

  defp refresh_tokens(conn) do
    case Spotify.Authentication.refresh(conn) do
      {:ok, new_conn} -> new_conn
      {:error, _} ->
        conn
        |> render("new_user.html")
        |> halt()
    end
  end
end
