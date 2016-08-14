import React from 'react';
import ReactDOM from 'react-dom';
import {RemindersHighlight} from './reminders_highlight';

export class Reminder extends React.Component {
  divLineStyle() {
    return {
      margin: '5px'
    }
  }

  iconStyle() {
    return {
      fontSize: '16px'
    }
  }

  render() {
    return(
      <div className="list-group-item">
        <h4>{this.props.title}</h4>
        <div style={this.divLineStyle()}>
          <RemindersHighlight title="6 times a Year" color='#ff40ff'></RemindersHighlight>
        </div>
        <div style={this.divLineStyle()}>
          You did it
          <RemindersHighlight title="once" color='#ff40ff'></RemindersHighlight>
          this Year
          <a>... and I did it right now</a>
        </div>
        <div style={this.divLineStyle()}>
          You did that the last time on
          <RemindersHighlight title="June 29th, 2016 12:27" color='#ff40ff'></RemindersHighlight>
        </div>
        <a>
          <div className='clearfix'>
            <span className='pull-right glyphicon glyphicon-trash' style={this.iconStyle()}></span>
          </div>
        </a>
      </div>
    )
  }
}
