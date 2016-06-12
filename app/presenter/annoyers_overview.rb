require 'ostruct'

class AnnoyersOverview
  attr_reader :annoyers
  attr_reader :recents

  def initialize(current_user_id)
    annoyers = Annoyer.where(user_id: current_user_id)
    build_annoyer_view_model(annoyers)
    build_recent_view_model(current_user_id)
  end

  private

  def build_annoyer_view_model(annoyers)
    annoyers_data = []
    annoyers.each do |annoyer|
      annoyers_data.push(annoyer_view_model_element(annoyer))
    end
    @annoyers = annoyers_data
  end

  def build_recent_view_model(current_user_id)
    recents = Annoyer.all_recents(current_user_id)
    recents_data = []
    recents.each do |recent|
      reminder = Reminder.where(id: recent.reminder_id).first
      recents_data.push(recent_view_model_element(recent, reminder))
    end
    @recents = recents_data

  end
  def annoyer_view_model_element(annoyer)
    latest_reminder = annoyer.latest_reminder
    nodes = Node.where annoyer_id: annoyer.id

    if latest_reminder
      OpenStruct.new(
        :annoyer => annoyer,
        :date => latest_reminder.latest_recent.created_at.to_formatted_s(:long_ordinal),
        :reminder => latest_reminder.title,
        :node_count => nodes.count
      )
    else
      OpenStruct.new(
        :annoyer => annoyer,
        :date => nil,
        :node_count => nodes.count
      )
    end
  end

  def recent_view_model_element(recent, reminder)
    OpenStruct.new(
      date: recent.created_at.to_formatted_s(:long_ordinal),
      reminder: reminder.title,
      color: Annoyer.where(id: reminder.annoyer_id).first.color
    )
  end
end
