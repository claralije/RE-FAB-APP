class Deal < ApplicationRecord

STATUS = ['in_process', 'closed']

  belongs_to :product
  belongs_to :user
  has_one :review

  validates :status, inclusion: { in: Deal::STATUS }
end
