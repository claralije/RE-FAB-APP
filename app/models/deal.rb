class Deal < ApplicationRecord

STATUS = ['pending', 'in_process', 'closed']

  belongs_to :product
  belongs_to :user
  has_one :review

  validates :status, inclusion: { in: Deal::STATUS }

  after_update :change_product_status

  def change_product_status

    if self.status == 'closed'
      self.product.update(status: 'sold')
      #binding.pry
    end
  end
end
