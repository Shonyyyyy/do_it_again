class Node < ActiveRecord::Base
  belongs_to :annoyer
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :annoyer_id, presence: true
end
