import React from 'react';
import ReactDOM from 'react-dom';

export class RemindersHighlight extends React.Component {
  labelStyle(){
    return {
      backgroundColor: this.props.color,
    }
  }

  render() {
    return(
      <div className="label label-annoyer-opacity" style={this.labelStyle()}>
        <i>
          {this.props.title}
        </i>
      </div>
    )
  }
}
