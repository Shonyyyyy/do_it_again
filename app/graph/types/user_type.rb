UserType = GraphQL::ObjectType.define do
  name "User"
  description "A User, contains useraccount data"
  # Expose fields associated with Post model
  field :id, types.ID, "This id of this user"
  field :email, types.String, "The email of this user"
  field :created_at, types.String, "The time at which this post was created"
end
