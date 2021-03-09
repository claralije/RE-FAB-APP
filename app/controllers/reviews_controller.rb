class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @deal = Deal.find(params[:deal_id])
    @review.user = current_user
    @review.deal = @deal

    authorize @review

    @review.save

    redirect_to product_path
  end

private

  def review_params
    params.require(:review).permit(:title, :rating, :content)
  end
end
