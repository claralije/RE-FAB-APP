class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

         SCHOOLS = ['Central Saint Martins', 'London College Of Fashion', 'Westminster', 'Goldsmiths', 'Istituto Marangoni', 'Kingston', 'Royal College of Art']

  has_one_attached :photo
  has_many :deals
  has_many :products
  has_many :favorites
  has_many :chatrooms
  has_many :messages
  has_many :received_reviews, through: :products, source: :review

  validates :name, presence: true, on: :update
  validates :location, presence: true, on: :update
  validates :bio, presence: true, on: :update
  validates :school, inclusion: { in: User::SCHOOLS }, on: :update

  #geocoded_by :city
  #after_validation :geocode, if: :will_save_change_to_city?

  # scope :received_reviews, -> (user) { joins(products: { deal: :review }).where(products: {user: user}) }


  def chat_with(user)
    Chatroom.find_by(user_a: self, user_b: user) ||
    Chatroom.find_by(user_b: self, user_a: user)
  end

  def has_favorite(product)
    self.favorites.find_by(product: product)
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice("provider", "uid")
    user_params.merge! auth.info.slice("email", "first_name", "last_name")
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def has_unread_messages?
    Message.joins(:chatroom).where(chatrooms: {user_a: self}).or(Message.joins(:chatroom).where(chatrooms: {user_b: self})).where(messages:{read: false}).where.not(messages:{user: self}).any?
  end

  def has_pending_deals_with(other_user)
    deals.joins(:product).where(products: {user: other_user}, deals: {status: 'pending'}).any?
  end
end
