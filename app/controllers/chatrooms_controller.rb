class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.where(user_a: current_user).or(Chatroom.where(user_b: current_user))
  end

  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])

  end
end
