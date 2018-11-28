import "phoenix_html"
import "jquery"

import { Channel, Socket } from "phoenix"

let addArtist = (artist) => {
  channel.push("add", {name: artist})
}

$("div.artist-card").click(function(){
  addArtist(this.textContent.trim())
})

let socket = new Socket("/socket", { params: { token: window.userToken } })

socket.connect()

let channel = socket.channel("app:artists", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
