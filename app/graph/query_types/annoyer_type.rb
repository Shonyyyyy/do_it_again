AnnoyerType = GraphQL::ObjectType.define do
  name "Annoyer"
  description "A Single Annoyer returns data of annoyer, user, nodes and reminders"
  # Expose fields associated with Post model
  field :id, !types.ID, "This id of this annoyer"
  field :title, types.String, "The title of this annoyer"
  field :color, types.String, "The color of this annoyer"
  field :created_at, types.String, "The time at which this annoyer was created"
  field :user do
    type !types[!UserType]
    resolve -> (obj, args, ctx) do
      User.where(id: obj.user_id)
    end
  end
  field :nodes do
    type !types[!NodeType]

    description "Nodes of this Annoyer"
    argument :limit, types.Int

    resolve -> (obj, args, ctx) do
      limit = args[:limit] ? args[:limit] : nil
      Node.where(annoyer_id: obj.id).limit(limit)
    end
  end
  field :reminders do
    type !types[!ReminderType]

    description "Reminders of this Annoyer"
    argument :limit, types.Int

    resolve -> (obj, args, ctx) do
      limit = args[:limit] ? args[:limit] : nil
      Reminder.where(annoyer_id: obj.id).limit(limit)
    end
  end
end
