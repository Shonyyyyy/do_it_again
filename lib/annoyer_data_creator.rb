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
end
