import React from 'react';
import Relay from 'react-relay';
import ReactDOM from 'react-dom';
import {RemindersContainer} from './react/reminders_components/reminders_container';
import {NodesContainer} from './react/nodes_components/nodes_container';

ReactDOM.render(
  <Relay.RootContainer
    Component={NodesContainer}
    route={new AnnoyerHomeRoute()}
  />,
  document.getElementById('nodes_container')
);

ReactDOM.render(
  <Relay.RootContainer
    Component={RemindersContainer}
    route={new AnnoyerHomeRoute()}
  />,
  document.getElementById('reminders_container')
);
