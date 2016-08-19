import Relay from 'react-relay';
]
export class AnnoyerHomeRoute extends Relay.Route {
  static routeName = 'Home';
  static queries = {
    store: (Component) => Relay.QL`
      query AnnoyerQuery {
        annoyer(id:1) { ${Component.getFragment('store')} },
      }
    `,
  };
}
