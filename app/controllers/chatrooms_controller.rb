class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.joins(:messages).where(chatrooms: { user_a: current_user} ).or(Chatroom.joins(:messages).where(chatrooms: { user_b: current_user})).distinct

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
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @product = Product.find(params[:product_id])
      @user =  @product.user
    end
    @chatroom = Chatroom.new(user_a: current_user, user_b: @user)
    authorize @chatroom
    @chatroom.save
    @message = Message.create(user: current_user, content: 'Is the product still available ?', product: @product, chatroom: @chatroom)
    redirect_to chatroom_path(@chatroom)
  end
end
