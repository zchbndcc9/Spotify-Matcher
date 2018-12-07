import React from 'react'
import axios from 'axios'
import { ArtistList } from '../components/artist-list';

export class Home extends React.Component {
  constructor(props) {
    super(props)
    this.state = { artists: [], pickedArtists: []}
  }

  componentDidMount() {
    axios.get("http://localhost:4000").then(result => {

    })
  }

  pickArtist(id) {
    axios.get(`http://localhost:4000/artist/${id}/similar`).then({status, artist} => {
      if(response.status === 200) {
        // Swap artist and add to picked artists
        const artistIndex = this.state.artists.findIndex(artist => artist.id === id)
        const pickedArtist = this.state.artists[artistIndex]
  
        this.setState((prevState) => ({
          artists: [
            prevState.artists.splice(0, artistIndex),
            artist,
            prevState.artists.splice(artistIndex + 1)
          ],
          pickedArtists: [...pickedArtists, pickedArtist]
        }))
      }
    })
  }

  render() {
    return(
      <ArtistList artists={this.state.artists} pickArtist={(id) => this.pickArtist(id)} />
    )
  }
}