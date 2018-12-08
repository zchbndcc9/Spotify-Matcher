use Mix.Config

config :spotify_ex, scopes: ["user-top-read", "user-read-private", "user-follow-modify", "user-follow-read", "playlist-read-private", "playlist-modify-public", "playlist-modify-private"],
                    callback_url: "http://localhost:4000/authenticate"
