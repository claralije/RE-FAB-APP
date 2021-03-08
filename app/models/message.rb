class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  belongs_to :product, optional: true

  validates :content, presence: true
end
