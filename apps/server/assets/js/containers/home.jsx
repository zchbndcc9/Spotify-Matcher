import React from 'react'
import axios from 'axios'
import ArtistList from '../components/artist-list';

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
    return(
      <ArtistList artists={this.state.artists} pickArtist={(id) => this.pickArtist(id)} />
    )
  }
}

export default Home