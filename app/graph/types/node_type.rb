NodeType = GraphQL::ObjectType.define do
  name "Node"
  description "A single node, which belongs to a certain annoyer"
  # Expose fields associated with Post model
  field :id, !types.ID, "This id of this node"
  field :title, types.String, "The title of this node"
  field :content, types.String, "The content of this node"
  field :created_at, types.String, "The time at which this node was created"
end
