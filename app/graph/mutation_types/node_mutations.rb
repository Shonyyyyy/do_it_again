module NodeMutations
  Add = GraphQL::Relay::Mutation.define do
    # Used to name derived types:
    name "AddNode"

    # Accessible from `input` in the resolve function:
    input_field :annoyer_id, !types.ID
    input_field :title, !types.String
    input_field :content, !types.String

    # The result has access to these fields,
    # resolve must return a hash with these keys
    return_field :node, NodeType

    # The resolve proc is where you alter the system state.
    resolve -> (inputs, ctx) {
      if UserSession.find.user.id == Annoyer.find(inputs[:annoyer_id]).user_id
        node = Node.create(annoyer_id: inputs[:annoyer_id], title: inputs[:title], content: inputs[:content])
        {node: node}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end

  Update = GraphQL::Relay::Mutation.define do
    # Used to name derived types:
    name "UpdateNode"

    # Accessible from `input` in the resolve function:
    input_field :node_id, !types.ID
    input_field :title, !types.String
    input_field :content, !types.String

    # The result has access to these fields,
    # resolve must return a hash with these keys
    return_field :node, NodeType

    # The resolve proc is where you alter the system state.
    resolve -> (inputs, ctx) {
      node = Node.find(inputs[:node_id])
      if UserSession.find.user.id == node.annoyer.user_id
        node.update(title: inputs[:title], content: inputs[:content])
        {node: node}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name "destroyNode"

    input_field :node_id, !types.ID

    return_field :deleted_id, !types.ID

    resolve -> (inputs, ctx) {
      if UserSession.find.user.id == Node.find(inputs[:node_id]).annoyer.user_id
        Node.destroy(inputs[:node_id])
        {deleted_id: inputs[:node_id]}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end
end
