class Product < ApplicationRecord

  FABRICS = ['silk', 'cotton', 'polyester', 'linen', 'leather', 'tencel', 'wool', 'latex', 'pineapple leather', 'faux fur']
  CONDITIONS = ['new', 'used']
  STATUS = ['available', 'sold']
  COLORS = ["White", "Yellow", "Blue", "Red", "Green", "Black", "Brown", "Purple", "Gray", "Orange", "pink", "Black"]

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  belongs_to :user
  has_one :deal
  has_one :message
  has_many_attached :photos
  has_one :review, through: :deal

  validates :title, presence: true
  validates :fabric, inclusion: { in: Product::FABRICS }
  validates :description, presence: true
  validates :condition, inclusion: { in: Product::CONDITIONS }
  validates :color, inclusion: { in: Product::COLORS }
  validates :price, presence: true
  validates :status, inclusion: { in: Product::STATUS }

  before_validation :assign_default_status, on: :create

  include PgSearch::Model
      pg_search_scope :search_by_user,
    associated_against: {
      user: [ :name]
    },
    using: {
      tsearch: { prefix: true }
    }

  private

  def assign_default_status
    self.status = 'available'
  end
end
