ReminderType = GraphQL::ObjectType.define do
  name "Reminder"
  description "A single reminder, which belongs to a certain annoyer"
  # Expose fields associated with Post model
  field :id, !types.ID, "This id of this reminder"
  field :title, types.String, "The title of this reminder"
  field :frequency, types.Int, "The content of this reminder"
  field :repeat, types.String, "The repeat value of this reminder"
  field :created_at, types.String, "The time at which this reminder was created"
  field :recents do
    type !types[!RecentType]

    description "Recents of this Reminder"

    resolve -> (obj, args, ctx) do
       Recent.where(
         reminder_id: obj.id
       )
     end
  end
end
