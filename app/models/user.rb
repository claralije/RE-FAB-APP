class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         SCHOOLS = ['Central Saint Martins', 'London College Of Fashion', 'Westminster', 'Goldsmiths', 'Istituto Marangoni', 'Kingston', 'Royal College of Art']

  has_one_attached :photo
  has_many :deals
  has_many :products
  has_many :favorites
  has_many :chatrooms
  has_many :messages

  validates :name, presence: true, on: :update
  validates :location, presence: true, on: :update
  validates :bio, presence: true, on: :update
  validates :school, inclusion: { in: User::SCHOOLS }, on: :update

  #geocoded_by :city
  #after_validation :geocode, if: :will_save_change_to_city?

  scope :received_reviews, -> (user) { joins(products: { deal: :review }).where(products: {user: user}) }


  def chat_with(user)
    Chatroom.find_by(user_a: self, user_b: user) ||
    Chatroom.find_by(user_b: self, user_a: user)
  end

  def has_favorite(product)
    self.favorites.find_by(product: product)
  end
end
