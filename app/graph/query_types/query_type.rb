QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema. See available queries."

  # Get Annoyer by ID
  field :annoyer, AnnoyerType do
    argument :id, !types.ID
    description 'Root object to get viewer related collections'
    resolve -> (obj, args, ctx) {
      Annoyer.find(args["id"])
    }
  end
end
