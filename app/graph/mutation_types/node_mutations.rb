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
      node = Node.create(annoyer_id: inputs[:annoyer_id], title: inputs[:title], content: inputs[:content])
      {node: node}
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
      node.update(title: inputs[:title], content: inputs[:content])
      {node: node}
    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name "destroyNode"

    input_field :node_id, !types.ID

    return_field :deleted_id, !types.ID

    resolve -> (inputs, ctx) {
      Node.destroy(inputs[:node_id])
      {deleted_id: inputs[:node_id]}
    }
  end
end
