class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @products = @user.products
    @favorites = @user.favorites
    authorize @user
    @pending_deals = @user.deals.where(status: 'pending')
    @in_process_deal = @user.deals.where(status: 'in_process')
    @closed_deals = @user.deals.where(status: 'closed')
    @my_product_deals = Deal.joins(:product).where('products.user_id = ?', current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :location, :school, :phone_number, :bio, :photo)
  end
end
