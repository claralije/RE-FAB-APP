class FavoritesController < ApplicationController
  # User can see all their favorites in one place

  # you can create a favorite by marking an EXISTING product as favorite
  # a favorite is linked to a product ID
  # only REGISTERED USERS can create favorites
  def create
    @product = Product.find(params[:product_id])
    @favorite = Favorite.new
    @favorite.product = @product
    @favorite.user = current_user
    @favorite.save
    redirect_to choose_redirection
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @product = @favorite.product
    @favorite.destroy

    redirect_to choose_redirection
  end

  private

  def choose_redirection
    if request.referer.match?(/products\/\d+/)
      product_path(@product)
    elsif request.referer.match?(/products/)
      products_path(anchor: "product-#{@product.id}")
    elsif request.referer.match?(/users/)
      user_path(@product.user)
    end

  end
end
