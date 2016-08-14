import React from 'react';
import ReactDOM from 'react-dom';
import {Reminder} from './reminder';

export class RemindersList extends React.Component {
  render() {
    return(
      <div className='list-group'>
        <Reminder title="Visit them at home"></Reminder>
      </div>
    )
  }
}
