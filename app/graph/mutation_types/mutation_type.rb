MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  # Add the mutation's derived field to the mutation type
  field :addAnnoyer, field: AnnoyerMutations::Add.field
  field :updateAnnoyer, field: AnnoyerMutations::Update.field
  field :destroyAnnoyer, field: AnnoyerMutations::Destroy.field
end
