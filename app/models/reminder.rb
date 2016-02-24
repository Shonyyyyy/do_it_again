class Reminder < ActiveRecord::Base
  enum repeat_values: ["Day", "Week", "Month", "Year"]

  belongs_to :annoyer
  has_many :recents, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :frequency, presence: true, length: { minimum: 1 }, :numericality => { :greater_than => 0}
  validates :repeat, presence: true, inclusion: { in: repeat_values.keys}
  validates :annoyer_id, presence: true

  def latest_recent
    recents.last
  end
end
