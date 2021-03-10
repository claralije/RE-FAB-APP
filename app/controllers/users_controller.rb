class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @products = @user.products
    @favorites = @user.favorites
    authorize @user
    @pending_deals = @user.deals.where(status: 'in_process')
    @closed_deals = @user.deals.where(status: 'closed')
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
