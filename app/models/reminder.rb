class Reminder < ActiveRecord::Base
  belongs_to :annoyer
  has_many :recents, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :frequency, presence: true, length: { minimum: 1 }
end
