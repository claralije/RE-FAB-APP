class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorites = @user.favorites
    authorize @user
  end
end
