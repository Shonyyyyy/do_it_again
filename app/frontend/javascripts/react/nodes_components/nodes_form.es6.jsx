import React from 'react';
import ReactDOM from 'react-dom';

export class NodesForm extends React.Component {
  render() {
    return(
      <div>
        <p>
          Add a new node!
          <form>
            <p>
              <div className="row">
                <div className="col-md-12">
                  <div className="input-group">
                    <span className="input-group-addon">
                      <span className="glyphicon glyphicon-font"></span>
                    </span>
                    <input type="text" className="form-control" placeholder="title" />
                  </div>
                </div>
              </div>
            </p>
            <p>
              <div className="row">
                <div className="col-md-12">
                  <div className="input-group">
                    <span className="input-group-addon">
                      <span className="glyphicon glyphicon-console"></span>
                    </span>
                    <input type="text" className="form-control form-group-lg" placeholder="content" />
                  </div>
                </div>
              </div>
            </p>
            <p>
              <button className="btn btn-primary pull-right">write node!</button>
            </p>
          </form>
        </p>
      </div>
    )
  }
}
