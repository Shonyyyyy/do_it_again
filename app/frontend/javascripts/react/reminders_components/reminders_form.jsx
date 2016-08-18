import React from 'react';
import ReactDOM from 'react-dom';

export class RemindersForm extends React.Component {
  render() {
    return(
      <div>
        <p>
          Add a new Reminder!
        </p>
        <form>
          <p>
            <div className="row">
              <div className="col-md-12">
                <div className="input-group">
                  <span className="input-group-addon">
                    <span className="glyphicon glyphicon-font"></span>
                  </span>
                  <input className="form-control" placeholder="title" type="text" />
                </div>
              </div>
            </div>
          </p>
          <p>
            <div className="row">
              <div className="col-md-6">
                <span>how often:</span>
                <div className="input-group">
                  <span className="input-group-addon">
                    <span className="glyphicon glyphicon-scale"></span>
                  </span>
                  <input className="form-control" placeholder="title" type="number" defaultValue="1" min="1"/>
                </div>
              </div>
              <div className="col-md-6">
                <span>...times each:</span>
                <div className="input-group">
                  <span className="input-group-addon">
                    <span className="glyphicon glyphicon-scale"></span>
                  </span>
                  <select className="form-control">
                    <option value="Day">Day</option>
                    <option value="Week">Week</option>
                    <option value="Month">Month</option>
                    <option value="Year">Year</option>
                  </select>
                </div>
              </div>
            </div>
          </p>
          <p>
            <div className="row">
              <div className="col-md-12">
                <input type="submit" name="commit" value="create reminder!" className="btn btn-primary btn pull-right" />
              </div>
            </div>
          </p>
        </form>
      </div>
    )
  }
}
