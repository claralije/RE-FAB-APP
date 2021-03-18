class Chatroom < ApplicationRecord
  belongs_to :user_a, class_name: 'User'
  belongs_to :user_b, class_name: 'User'

  has_many :messages, dependent: :destroy
  has_many :products, through: :messages
  has_many :deals, through: :products

  def other_user(user)
    if self.user_a == user
      return user_b
    else
      return user_a
    end
  end
end
