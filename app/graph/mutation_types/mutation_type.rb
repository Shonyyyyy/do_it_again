MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  # Add the mutation's derived field to the mutation type
  field :addAnnoyer, field: AnnoyerMutations::Add.field
  field :updateAnnoyer, field: AnnoyerMutations::Update.field
  field :destroyAnnoyer, field: AnnoyerMutations::Destroy.field

  field :addNode, field: NodeMutations::Add.field
  field :updateNode, field: NodeMutations::Update.field
  field :destroyNode, field: NodeMutations::Destroy.field

  field :addReminder, field: ReminderMutations::Add.field
  field :updateReminder, field: ReminderMutations::Update.field
  field :destroyReminder, field: ReminderMutations::Destroy.field

  field :addRecent, field: RecentMutations::Add.field
end
