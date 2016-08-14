import React from 'react';
import ReactDOM from 'react-dom';
import {Node} from './node';

export class NodesList extends React.Component {
  panelHeadingStyle() {
    return {
      backgroundColor: '#ff40ff',
      color: '#fff',
      opacity: '0.6'
    }
  }

  render() {
    return(
      <div className="panel panel-default">
        <div style={this.panelHeadingStyle()} className="panel-heading">Nodes</div>
        <div className="panel-body">
          <Node title="25th Annual Party">This Party is in the neighbour town on 06.06.16</Node>
        </div>
      </div>
    )
  }
}
