QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema. See available queries."

  # Get Annoyer by ID
  field :annoyer, AnnoyerType do
    argument :id, !types.ID
    description 'Root object to get viewer related collections'
    resolve -> (obj, args, ctx) {
      annoyer = Annoyer.find(args["id"])
      if UserSession.find.user.id == annoyer.user_id
        Annoyer.find(args["id"])
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end
end
