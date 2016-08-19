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
        <RemindersForm></RemindersForm>
      </div>
    )
  }
}

ReminderFragment = Relay.createContainer(Reminder, {
  fragments: {
    reminder: () => Relay.QL`
      fragment on Reminder {
        title,
        frequency,
        repeat,
      }
    `,
  },
});

RemindersContainer = Relay.createContainer(RemindersContainer, {
  fragments: {
    store: () => Relay.QL`
      fragment on Annoyer {
        reminder { ${NodeFragment.getFragment('reminder')} },
      }
    `,
  },
});
