import React from "react";
import ReactDOM from "react-dom";
import {ReminderHighlight} from "./reminder_highlight";

export class Reminder extends React.Component {
  divLineStyle() {
    return {
      margin: "5px"
    }
  }

  iconStyle() {
    return {
      fontSize: "16px"
    }
  }

  getFormattedFrequency() {
    if(this.props.frequency > 2) {
      var formattedFrequency = `${this.props.frequency} times`;
    } else if (this.props.frequency == 1) {
      var formattedFrequency = "once";
    } else {
      var formattedFrequency = "twice";
    }

    return(
      <div style={this.divLineStyle()}>
        <ReminderHighlight title={`${formattedFrequency} a ${this.props.repeat}`} color="#ff40ff"></ReminderHighlight>
      </div>
    )
  }

  getFormattedAmount() {
    let formattedAmount = `${this.props.amount} times`;
    switch(this.props.amount) {
      case "0":
        formattedAmount = "never";
        break;
      case "1":
        formattedAmount = "once";
        break;
      case "2":
        formattedAmount = "twice";
        break;
      default:
        break;
    }

    return(
      <div style={this.divLineStyle()}>
        {"You did it "}
        <ReminderHighlight title={formattedAmount} color="#ff40ff"></ReminderHighlight>
        this {this.props.repeat}
        <a>{"... and I did it right now"}</a>
      </div>
    )
  }

  getLatestFormatted() {
    return(
      <div style={this.divLineStyle()}>
        {"You did that the last time on "}
        <ReminderHighlight title={this.props.latest} color="#ff40ff"></ReminderHighlight>
      </div>
    )
  }

  render() {
    return(
      <div className="list-group-item">
        <h4>{this.props.title}</h4>
        {this.getFormattedFrequency()}
        {this.getFormattedAmount()}
        {this.getLatestFormatted()}
        <a>
          <div className="clearfix">
            <span className="pull-right glyphicon glyphicon-trash" style={this.iconStyle()}></span>
          </div>
        </a>
      </div>
    )
  }
}
