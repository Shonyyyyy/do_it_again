module AnnoyersHelper
  def get_amount_of_nodes annoyer
    nodes = Node.where annoyer_id: annoyer.id
    nodes.count
  end
  def get_latest_recent annoyer
    reminders = Reminder.where annoyer_id: annoyer.id
    latest_recent = Date.new
    latest_reminder = reminders.last
    
    reminders.each do |reminder|
      recent_tmp = reminder.recents.order("created_at").last
      if latest_recent < recent_tmp.created_at
        latest_recent = recent_tmp.created_at
        latest_reminder = reminder
      end
    end

    {date: latest_recent.to_formatted_s(:long_ordinal), recent: latest_reminder.title}
  end
end
