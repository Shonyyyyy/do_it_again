import React from 'react';
import ReactDOM from 'react-dom';
import {Reminder} from './reminder';

export class RemindersList extends React.Component {
  render() {
    let l10nDE = new Intl.DateTimeFormat("de-DE");
    return(
      <div className="list-group">
        <Reminder
          title="Visit them at home"
          frequency="6"
          repeat="week"
          amount="2"
          latest={l10nDE.format(new Date("2016-06-29"))}
        ></Reminder>
      </div>
    )
  }
}
