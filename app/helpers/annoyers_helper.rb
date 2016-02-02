module AnnoyersHelper
  def get_amount_of_nodes annoyer
    nodes = Node.where annoyer_id: annoyer.id
    nodes.count
  end

  def get_latest_recent annoyer
    reminder_ids = Reminder.select(:id).where annoyer_id: annoyer.id
    recent = Recent.where(reminder_id: reminder_ids).last
    latest_reminder = Reminder.where(id: recent.reminder_id).first

    {date: recent.created_at.to_formatted_s(:long_ordinal), reminder: latest_reminder.title}
  end

  def get_overall_latest_recents annoyers
    reminder_ids = Reminder.select(:id).where(annoyer_id: annoyers.map(&:id))
    all_recents = Recent.where reminder_id: reminder_ids
    recents = all_recents.order("created_at desc").limit("10")

    recent_reminder_arr = Array.new
    recents.each do |recent|
      recents_reminder = Reminder.where(id: recent.reminder_id).first
      recent_reminder_arr.push(
        {
          date: recent.created_at.to_formatted_s(:long_ordinal),
          reminder: recents_reminder.title,
          color: Annoyer.where(id: recents_reminder.annoyer_id).first.color
        }
      )
    end

    return recent_reminder_arr
  end
end
