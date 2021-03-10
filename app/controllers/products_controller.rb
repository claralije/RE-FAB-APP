class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all

    if params[:location].present?
      # @users_id = User.near(params[:location], 50).map { |user| user.id }
      @products = Product.search_by_location(params[:location])
    end

    if params[:fabric].present?
      @products = @products.where(fabric: params[:fabric])
    end

    if params[:color].present?
      @products = @products.where(color: params[:color])
    end

    if params[:price].present?
      price_range = params[:price].map do |number|
        if number == "10"
          (1...10).to_a
        elsif number == "20"
          (11..20).to_a
        elsif number == "30"
          (21..30).to_a
          elsif number == "40"
          (31..40).to_a
          elsif number == "50"
          (41..500).to_a
        end
      end
      @products = @products.where(price: price_range.flatten)
    end

    if params[:quantity].present?
      quantity_range = params[:quantity].map do |number|
        if number == "10"
          (1...10).to_a
        elsif number == "20"
          (11..20).to_a
        elsif number == "30"
          (21..30).to_a
          elsif number == "40"
          (31..40).to_a
          elsif number == "50"
          (41..500).to_a
        end
      end
      @products = @products.where(quantity: quantity_range.flatten)
    end
    @markers = @products.geocoded.map do |product|
      {
        lat: product.latitude,
        lng: product.longitude
      }
    end
  end

  def show
    @product = Product.find(params[:id])
    @chat_with_owner = current_user.chat_with(@product.user)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to products_path(@products)
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)

    redirect_to product_path(@product)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

private

  def product_params
    params.require(:product).permit(:title, :fabric, :description, :condition, :weight, :quantity, :color, :price, photos: [])
  end
end
