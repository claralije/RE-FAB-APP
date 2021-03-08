class Product < ApplicationRecord

  FABRICS = ['silk', 'cotton', 'polyester', 'linen', 'leather', 'tencel', 'wool', 'latex', 'pineapple leather', 'faux fur']
  CONDITIONS = ['new', 'used']
  STATUS = ['available', 'sold']

  # has_many_attached :photos
  belongs_to :user
  has_one :deal

  validates :title, presence: true
  validates :fabric, inclusion: { in: Product::FABRICS }
  validates :description, presence: true
  validates :condition, inclusion: { in: Product::CONDITIONS }
  validates :color, presence: true
  validates :price, presence: true
  validates :status, inclusion: { in: Product::STATUS }

  before_validation :assign_default_status, on: :create

  # geocoded_by :location
  # after_validation :geocode, if: :will_save_change_to_city?

  private

  def assign_default_status
    self.status = 'available'
  end
end
