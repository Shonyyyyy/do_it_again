class Annoyer < ActiveRecord::Base
  has_many :nodes, dependent: :destroy
  has_many :reminders, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :color, presence: true, length: { minimum: 6 }

  def latest_reminder
    recent = Recent.where(reminder_id: reminders.select(:id)).last
    Reminder.where(id: recent.reminder_id).first
  end
end
