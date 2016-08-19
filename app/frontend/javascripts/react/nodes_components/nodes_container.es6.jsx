import React from 'react';
import Relay from 'react-relay'
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

NodeFragment = Relay.createContainer(Node, {
  fragments: {
    node: () => Relay.QL`
      fragment on Node {
        title,
        content,
      }
    `,
  },
});

NodesContainer = Relay.createContainer(NodesContainer, {
  fragments: {
    store: () => Relay.QL`
      fragment on Annoyer {
        nodes { ${NodeFragment.getFragment('node')} },
      }
    `,
  },
});
