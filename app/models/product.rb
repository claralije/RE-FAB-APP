class Product < ApplicationRecord

  FABRICS = ['silk', 'cotton', 'polyester', 'linen', 'leather', 'tencel', 'wool', 'latex', 'faux fur']
  CONDITIONS = ['new', 'used']
  STATUS = ['available', 'sold']
  COLORS = ["White", "Yellow", "Blue", "Red", "Green", "Black", "Brown", "Azure", "Ivory", "Teal", "Silver", "Purple", "Navy blue", "Pea green", "Gray", "Orange", "Maroon", "Charcoal", "Aquamarine", "Coral", "Fuchsia", "Wheat", "Lime", "Crimson", "Khaki", "Hot pink", "Magenta", "Olden", "Plum", "Olive", "Cyan"]
  PRICE_OPTIONS = [[1,10],[11,20],[21,30],[31,40],[41,50],[51,'++']]
  QUANTITY = [[1,10],[11,20],[21,30],[31,40],[41,'++']]
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
