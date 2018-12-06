import "phoenix_html"

import React from "react"
import ReactDOM from "react-dom"
import { BrowserRouter as Router, Route, Link } from "react-router-dom"

class ReactApp extends React.Component {
  render() {
    return (
      <h1>Hello world</h1>
    )
  }
}

ReactDOM.render( <ReactApp/>, document.getElementById("react-app"))