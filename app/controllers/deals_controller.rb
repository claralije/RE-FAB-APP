class DealsController < ApplicationController

def show
    @deal = Deal.find(params[:id])
    @review = Review.new(deal: @deal)

    authorize @deal
  end

  def create
    @product = Product.find(params[:product_id])
    @deal = Deal.new()
    @deal.product = @product
    @deal.user = current_user
    @chatroom = @product.message.chatroom
    authorize @deal
    if @deal.save
      Message.create(user: current_user, content: "#{current_user.name} confirmed the deal", chatroom: @chatroom )
      redirect_to chatroom_path(@chatroom)
    else
      @message = Message.new
      @products = @chatroom.products
      render 'chatrooms/show'
    end
  end

  def update
    @deal = Deal.find(params[:id])
    @deal.update(deal_params)
    authorize @deal

    redirect_to deal_path(@deal)
  end

  def in_process
    @deal = Deal.find(params[:id])
    authorize @deal
    @chat = current_user.chat_with(@deal.user)
    Message.create(user: current_user, content: "#{current_user.name} has approved your Deal. It is now in process", chatroom: @chat )

    @deal.status = 'in_process'

    @deal.save

    redirect_to @chat
  end

  def closed
    @deal = Deal.find(params[:id])
    authorize @deal
    @deal.status = 'closed'

    @deal.save

    redirect_to user_path(current_user)
  end

  private

  def deal_params
    params.require(:deal).permit(:status)
  end

end
