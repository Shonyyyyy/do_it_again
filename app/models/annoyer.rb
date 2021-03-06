class Annoyer < ActiveRecord::Base
  has_many :nodes, dependent: :destroy
  has_many :reminders, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :color, presence: true, length: { minimum: 6 }
  validates :user_id, presence: true

  def latest_reminder
    recents = Recent.where(reminder_id: reminders.select(:id))
    recent = recents.order('created_at ASC').last
    if recent
      Reminder.where(id: recent.reminder_id).first
    end
  end

  def self.all_recents(user_id)
    annoyers = Annoyer.where(user_id: user_id)
    reminder_ids = Reminder.select(:id).where(annoyer_id: annoyers.map(&:id))
    all_recents = Recent.where(reminder_id: reminder_ids)
    all_recents.order("created_at desc").limit("10")
  end
end
