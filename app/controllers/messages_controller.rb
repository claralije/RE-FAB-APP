class MessagesController < ApplicationController

  def create
    @product = Product.find(params[:product_id]) if params[:product_id].present?
    @chatroom = Chatroom.find(params[:chatroom_id])
    if @product
      @message = Message.new(content: "Im interested in it")
    else
      @message = Message.new(message_params)
    end
    @message.product = @product
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      @products = @chatroom.products
      render "chatrooms/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end
