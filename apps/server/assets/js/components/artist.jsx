import React from 'react'

const card = {
  height: "3em",
  cursor: "pointer"
}

const cardImg = {
  borderRadius: "50%",
  width: "3em",
  height: "3em"
}

export const Artist = (artist: {name, id, img}, pickArtist) => (
  <div class="card" style={card} onClick={() => pickArtist(id)}>
    <img src={img.url} alt={img.url} style={cardImg}/>
    <h6>{name}</h6>
  </div>
)