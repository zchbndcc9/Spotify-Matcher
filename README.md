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
