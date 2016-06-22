RecentType = GraphQL::ObjectType.define do
  name "Recent"
  description "A single recent, which belongs to a certain reminder"
  # Expose fields associated with Post model
  field :id, !types.ID, "This id of this recent"
  field :created_at, types.String, "The time at which this recent was created"
end
