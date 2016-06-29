module ReminderMutations
  Add = GraphQL::Relay::Mutation.define do
    # Used to name derived types:
    name "AddReminder"

    # Accessible from `input` in the resolve function:
    input_field :annoyer_id, !types.ID
    input_field :title, !types.String
    input_field :frequency, !types.Int
    input_field :repeat, !types.String

    # The result has access to these fields,
    # resolve must return a hash with these keys
    return_field :reminder, ReminderType

    # The resolve proc is where you alter the system state.
    resolve -> (inputs, ctx) {
      if UserSession.find.user.id == Annoyer.find(inputs[:annoyer_id]).user_id
        reminder = Reminder.create(annoyer_id: inputs[:annoyer_id], title: inputs[:title], frequency: inputs[:frequency], repeat: inputs[:repeat])
        {reminder: reminder}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end

  Update = GraphQL::Relay::Mutation.define do
    # Used to name derived types:
    name "UpdateReminder"

    # Accessible from `input` in the resolve function:
    input_field :reminder_id, !types.ID
    input_field :title, !types.String
    input_field :frequency, !types.Int
    input_field :repeat, !types.String

    # The result has access to these fields,
    # resolve must return a hash with these keys
    return_field :reminder, ReminderType

    # The resolve proc is where you alter the system state.
    resolve -> (inputs, ctx) {
      reminder = Reminder.find(inputs[:reminder_id])
      if UserSession.find.user.id == reminder.annoyer.user_id
        reminder.update(title: inputs[:title], frequency: inputs[:frequency], repeat: inputs[:repeat])
        {reminder: reminder}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name "destroyReminder"

    input_field :reminder_id, !types.ID

    return_field :deleted_id, !types.ID

    resolve -> (inputs, ctx) {
      if UserSession.find.user.id == Reminder.find(inputs[:reminder_id]).annoyer.user_id
        reminder.destroy
        {deleted_id: inputs[:reminder_id]}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end
end
