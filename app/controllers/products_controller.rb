class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.where.not(status: 'sold')

    if params[:location].present?
      # @users_id = User.near(params[:location], 50).map { |user| user.id }
      @products = Product.near(params[:location], 30)
    end

    if params[:query].present?
      # @users_id = User.near(params[:location], 50).map { |user| user.id }
      @products = Product.search_by_user(params[:query])
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

    if params[:my_products].present?
      @products = Product.where(user: current_user)
    end

    if params[:user_id].present?
      @products = Product.where(user_id: params[:user_id])
    end

    @markers = @products.geocoded.map do |product|
      {
        lat: product.latitude,
        lng: product.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { product: product })
      }
    end
  end

  def show
    @product = Product.find(params[:id])
    @chat_with_owner = current_user.chat_with(@product.user)
    authorize @product
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product
    if @product.save
      redirect_to products_path(my_products: true)
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    authorize @product

    redirect_to product_path(@product)
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product
    @product.destroy

    redirect_to products_path
  end

private

  def product_params
    params.require(:product).permit(:title, :fabric, :description, :condition, :weight, :quantity, :color, :price, :location, photos: [])
  end
end
