module RecentMutations
  Add = GraphQL::Relay::Mutation.define do
    # Used to name derived types:
    name "AddRecent"

    # Accessible from `input` in the resolve function:
    input_field :reminder_id, !types.ID
    # The result has access to these fields,
    # resolve must return a hash with these keys
    return_field :reminder, ReminderType

    # The resolve proc is where you alter the system state.
    resolve -> (inputs, ctx) {
      if UserSession.find.user.id == Reminder.find(inputs[:reminder_id]).annoyer.user_id
        reminder = Reminder.find(reminder_id)
        reminder.recents.create
        {reminder: reminder}
      else
        raise StandardError.new("No Permission, since no valid UserSession")
      end
    }
  end
end
