class Annoyer < ActiveRecord::Base
  has_many :nodes, dependent: :destroy
  has_many :reminders, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :color, presence: true, length: { minimum: 6 }
end
