class Product < ApplicationRecord

  FABRICS = ['silk', 'cotton', 'polyester', 'linen', 'leather', 'tencel', 'wool', 'latex', 'pineapple leather', 'faux fur']
  CONDITIONS = ['new', 'used']
  STATUS = ['available', 'sold']
  COLORS = ["White", "Yellow", "Blue", "Red", "Green", "Black", "Brown", "Azure", "Ivory", "Teal", "Silver", "Purple", "Navy blue", "Pea green", "Gray", "Orange", "Maroon", "Charcoal", "Aquamarine", "Coral", "Fuchsia", "Wheat", "Lime", "Crimson", "Khaki", "Hot pink", "Magenta", "Olden", "Plum", "Olive", "Cyan"]

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  belongs_to :user
  has_one :deal
  has_many_attached :photos

  validates :title, presence: true
  validates :fabric, inclusion: { in: Product::FABRICS }
  validates :description, presence: true
  validates :condition, inclusion: { in: Product::CONDITIONS }
  validates :color, inclusion: { in: Product::COLORS }
  validates :price, presence: true
  validates :status, inclusion: { in: Product::STATUS }

  before_validation :assign_default_status, on: :create

  # geocoded_by :location
  # after_validation :geocode, if: :will_save_change_to_city?
    # [...]
    include PgSearch::Model
    pg_search_scope :search_by_location,
      against: [ :location],
      using: {
        tsearch: { prefix: true } # <-- now `superman batm` will return something!
      }

  private

  def assign_default_status
    self.status = 'available'
  end
end
