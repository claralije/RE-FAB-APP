class Review < ApplicationRecord
  belongs_to :deal
  belongs_to :user
  validates :content, presence: true
  validates :title, presence: true
  validates :rating, presence: true, numericality: { greater_than: 1, less_than_or_equal_to: 5 }

  # after_create :update_kid_average_rating

  # def update_kid_average_rating
  #   kid = self.booking.kid
  #   ratings_array = kid.reviews.pluck(:rating)
  #   kid.averate_rating = ratings_array.sum / ratings_array.count.to_f
  #   kid.save
  # end
end
