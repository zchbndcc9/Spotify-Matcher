import React from 'react'
import axios from 'axios'
import ArtistList from '../components/artist-list'

class Home extends React.Component {
  constructor(props) {
    super(props)
    this.state = { artists: [], pickedArtists: []}
  }

  componentDidMount() {
    axios.get("http://localhost:4000/api/top-artists").then(({status, data: {artists}}) => {
      if(status === 200) {
        this.setState((prevState) => ({
          artists: artists
        }))
      }
    })
  }

  pickArtist(id) {
    axios.get(`http://localhost:4000/api/artists/${id}/similar`).then(({status, data: {artist}}) => {
      if(status === 200) {
        // Swap artist and add to picked artists
        const artistIndex = this.state.artists.findIndex(artist => artist.id === id)
        const pickedArtist = this.state.artists[artistIndex]
  
        console.log(pickedArtist);
        this.setState((prevState) => ({
          artists: [
            ...prevState.artists.slice(0, artistIndex),
            artist,
            ...prevState.artists.slice(artistIndex + 1)
          ],
          pickedArtists: [...prevState.pickedArtists, pickedArtist]
        }))
      }
    })
  }

  render() {
    const message = this.state.pickedArtists.length < 5 ? "Please pick at least 5 artists" : "Good to go!"
    return(
      <div className="row">
        <h2>{message}</h2>
        <ArtistList artists={this.state.artists} pickArtist={(id) => this.pickArtist(id)} />
        <form className="form">
          <div className="form-group">
            <label htmlFor="title">Playlist Title</label>
            <input id="title" className="form-control" type="text" placeholder="My cool playlist" required/>
          </div>
          <div className="form-group">
            <label htmlFor="num-songs">Number of Songs</label>
            <div className="form-check form-check-inline">
              <label className="form-check-label" htmlFor="input1">10</label>
              <input className="form-check-input" type="radio" name="num-songs" id="input1" value="10" required/>
            </div>
            <div className="form-check form-check-inline">
              <label className="form-check-label" htmlFor="input2">30</label>
              <input className="form-check-input" type="radio" name="num-songs" id="input2" value="30" required/>
            </div>
            <div className="form-check form-check-inline">
              <label className="form-check-label" htmlFor="input3">50</label>
              <input className="form-check-input" type="radio" name="num-songs" id="input3" value="50" required/>
            </div>
          </div>
          <button className="btn btn-success" disabled={this.state.pickedArtists.length < 5}>Create playlist</button>
        </form>
      </div>
    )
  }
}

export default Home