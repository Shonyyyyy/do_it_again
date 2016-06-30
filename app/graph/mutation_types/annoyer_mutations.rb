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
      if UserSession.find.user.id == inputs[:user_id].to_i
        annoyer = Annoyer.create(user_id: inputs[:user_id], title: inputs[:title], color: inputs[:color])
        {annoyer: annoyer}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end

  Update = GraphQL::Relay::Mutation.define do
    # Used to name derived types:
    name "UpdateAnnoyer"

    # Accessible from `input` in the resolve function:
    input_field :annoyer_id, !types.ID
    input_field :title, !types.String
    input_field :color, !types.String

    # The result has access to these fields,
    # resolve must return a hash with these keys
    return_field :annoyer, AnnoyerType

    # The resolve proc is where you alter the system state.
    resolve -> (inputs, ctx) {
      annoyer = Annoyer.find(inputs[:annoyer_id])
      if UserSession.find.user.id == annoyer.user_id
        annoyer.update(title: inputs[:title], color: inputs[:color])
        {annoyer: annoyer}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name "destroyAnnoyer"

    input_field :annoyer_id, !types.ID

    return_field :deleted_id, !types.ID

    resolve -> (inputs, ctx) {
      if UserSession.find.user.id == Annoyer.find(inputs[:annoyer_id]).user_id
        Annoyer.destroy(inputs[:annoyer_id])
        {deleted_id: inputs[:annoyer_id]}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end
end
