class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.where(user_a: current_user).or(Chatroom.where(user_b: current_user))

  end

  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])
    @products = @chatroom.products
    @deal = Deal.joins(:product).where('products.user_id = ? AND deals.user_id = ?', current_user.id, @chatroom.other_user(current_user).id).last

    authorize @chatroom
  end


  def create
    #careful, inplement an if statement with params user_id when entry point is user profile
    @product = Product.find(params[:product_id])
    @chatroom = Chatroom.new(user_a: current_user, user_b: @product.user)
    authorize @chatroom
    @chatroom.save
    @message = Message.create(user: current_user, content: 'Is the product still available ?', product: @product, chatroom: @chatroom)
    redirect_to chatroom_path(@chatroom)
  end
end
