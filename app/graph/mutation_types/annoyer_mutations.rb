module AnnoyerMutations
  Add = GraphQL::Relay::Mutation.define do
    # Used to name derived types:
    name "AddAnnoyer"

    # Accessible from `input` in the resolve function:
    input_field :user_id, !types.ID
    input_field :title, !types.String
    input_field :color, !types.String

    # The result has access to these fields,
    # resolve must return a hash with these keys
    return_field :annoyer, AnnoyerType

    # The resolve proc is where you alter the system state.
    resolve -> (inputs, ctx) {
      annoyer = Annoyer.create(user_id: inputs[:user_id], title: inputs[:title], color:[:color])
      {annoyer: annoyer}
    }
  end
end
