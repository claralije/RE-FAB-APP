class Chatroom < ApplicationRecord
  belongs_to :user_a, class_name: 'User'
  belongs_to :user_b, class_name: 'User'

  has_many :messages

  def other_user(current_user)
    if self.user_a == current_user
      return user_b
    else
      return user_a
    end
  end
end
