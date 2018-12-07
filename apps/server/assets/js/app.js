import "phoenix_html"

import React from "react"
import ReactDOM from "react-dom"
import { BrowserRouter as Router, Route, Link } from "react-router-dom"
import Home from './containers/home'
class ReactApp extends React.Component {
  render() {
    return(
      <Home/>
    )
  }
}

ReactDOM.render( <ReactApp/>, document.getElementById("react-app"))