# SpotifyCurator

## Background
For this application, I wanted to focus on improving the following skills:
  - Improving my knowledge about interacting with an API
  - Concurrent programming (primarily asyncronous HTTP requests)
  - State Management via `GenServers`
  - Functional Programming concepts and pipelining

## How to Run 
1. Start up the server
```elixir
  mix deps.get
  mix phx.server
```
2. Navigate to http://localhost:4000/authorize in order to authorize the application to access your spotify

3. Navigate to http://localhost:4000 and have fun creating your playlist!

**Warning**
Due to the limitations of the Spotify API, some playlist creation processes may not 
be successfully fulfilled in a timely manner. In order to combat this, I call the `add_songs` function recursively until it
is successful. That being said, some requests may take longer than others. There 
will be a fix for this in the near future
