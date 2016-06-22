MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  # Add the mutation's derived field to the mutation type
  field :addAnnoyer, field: AnnoyerMutations::Add.field
end
