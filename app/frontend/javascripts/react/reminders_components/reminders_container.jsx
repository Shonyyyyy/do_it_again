import React from 'react';
import ReactDOM from 'react-dom';
import {RemindersList} from './reminders_list';
import {RemindersForm} from './reminders_form';

export class RemindersContainer extends React.Component {
  render() {
    return(
      <div>
        <h3>Your Reminders</h3>
        <RemindersList></RemindersList>
      </div>
    )
  }
}

ReactDOM.render(<RemindersContainer/>, document.getElementById('reminders_container'));
