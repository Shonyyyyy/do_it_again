module AnnoyersHelper
  def get_amount_of_nodes annoyer
    nodes = Node.where annoyer_id: annoyer.id
    nodes.count
  end

  def latest_recent_data annoyer
    latest_reminder = annoyer.latest_reminder
    {date: latest_reminder.latest_recent.created_at.to_formatted_s(:long_ordinal), reminder: latest_reminder.title}
  end

  def get_overall_latest_recents annoyers
    reminder_ids = Reminder.select(:id).where(annoyer_id: annoyers.map(&:id))
    all_recents = Recent.where reminder_id: reminder_ids
    recents = all_recents.order("created_at desc").limit("10")

    map_recent_reminder_data recents
  end

  private
    def map_recent_reminder_data recents
      recent_reminder_arr = Array.new
      recents.each do |recent|
        recents_reminder = Reminder.where(id: recent.reminder_id).first
        recent_reminder_arr.push({
            date: recent.created_at.to_formatted_s(:long_ordinal),
            reminder: recents_reminder.title,
            color: Annoyer.where(id: recents_reminder.annoyer_id).first.color
        })
      end
      return recent_reminder_arr
    end
end
