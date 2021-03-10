class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.where(user_a: current_user).or(Chatroom.where(user_b: current_user))
  end

  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])
    @products = @chatroom.products
  end


  def create
    #careful, inplement an if statement with params user_id when entry point is user profile
    @product = Product.find(params[:product_id])
    @chatroom = Chatroom.create(user_a: current_user, user_b: @product.user)
    @message = Message.create(user: current_user, content: 'Is the product still available ?', product: @product, chatroom: @chatroom)
    redirect_to chatroom_path(@chatroom)
  end
end
