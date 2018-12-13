import React from 'react'

const card = {
  cursor: "pointer",
}

const cardImg = {
  borderRadius: "50%",
  width: "3em",
  height: "3em",
  marginRight: "2em"
}

const Artist = ({artist: {name, id, img}, pickArtist}) => (
  <div className="card" style={card} onClick={() => pickArtist(id)}>
    <div className="card-body d-flex align-items-center">
      <img src={img.url} alt={img.url} style={cardImg}/>
      <h5>{name}</h5>
    </div>
  </div>
)

export default Artist