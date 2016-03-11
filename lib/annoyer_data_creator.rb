module AnnoyerDataCreator
  def index_annoyer_data annoyers
    annoyers_data = []
    annoyers.each do |annoyer|
      annoyers_data.push(annoyer_data(annoyer))
    end
    return annoyers_data
  end

  def annoyer_data annoyer
    latest_reminder = annoyer.latest_reminder
    nodes = Node.where annoyer_id: annoyer.id

    if latest_reminder
      {
        annoyer: annoyer,
        date: latest_reminder.latest_recent.created_at.to_formatted_s(:long_ordinal),
        reminder: latest_reminder.title,
        node_count: nodes.count
      }
    else
      {
        annoyer: annoyer,
        date: nil,
        node_count: nodes.count
      }
    end
  end

  def index_recents_data annoyers
    recents = Annoyer.all_recents current_user.id
    recents_data = []
    recents.each do |recent|
      reminder = Reminder.where(id: recent.reminder_id).first
      recents_data.push({
          date: recent.created_at.to_formatted_s(:long_ordinal),
          reminder: reminder.title,
          color: Annoyer.where(id: reminder.annoyer_id).first.color
      })
    end
    return recents_data
  end

  def show_reminder_data annoyer
    reminders = annoyer.reminders
    reminders_data = []

    reminders.each do |reminder|
      latest_recent = reminder.recents.order("created_at").last
      latest_date = latest_recent.created_at.to_formatted_s(:long_ordinal)

      reminders_data.push({
        reminder: reminder,
        amount: recent_amount(reminder),
        latest_recent_date: latest_date,
      })
    end
    return reminders_data
  end

  def recent_amount reminder
    case reminder.repeat
    when "Day"
      cycle = Time.now - 24.hours
    when "Week"
      cycle = Time.now - 7.days
    when "Month"
      cycle = Time.now - 1.month
    when "Year"
      cycle = Time.now - 1.year
    end
    reminder.recents.where("created_at > ?", cycle).count
  end
end
