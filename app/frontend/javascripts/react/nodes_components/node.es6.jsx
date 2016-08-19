import React from 'react';
import ReactDOM from 'react-dom';

export class Node extends React.Component {
  spanTrashIconStyle() {
    return {
      fontSize: "16px"
    }
  }

  render() {
    return(
      <div>
        <h4>{this.props.title}</h4>
        <i>{this.props.children}</i>
        <a>
          <div className="clearfix">
            <span style={this.spanTrashIconStyle()} className="pull-right glyphicon glyphicon-trash"></span>
          </div>
        </a>
      </div>
    )
  }
}
