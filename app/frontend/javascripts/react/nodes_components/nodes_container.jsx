import React from 'react';
import ReactDOM from 'react-dom';
import {NodesList} from './nodes_list';
import {NodesForm} from './nodes_form';

export class NodesContainer extends React.Component {
  render() {
    return(
      <div>
        <h3>Nodes and Posts</h3>
        <NodesList></NodesList>
        <NodesForm></NodesForm>
      </div>
    )
  }
}

ReactDOM.render(<NodesContainer/>, document.getElementById('nodes_container'));
