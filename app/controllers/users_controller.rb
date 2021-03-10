class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorites = @user.favorites
  end
end
