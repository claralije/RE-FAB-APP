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
      Message.create(user: current_user, content: "✓ DEAL REQUEST SUCCESFULLY SENT. AWAITING RESPONSE FROM // #{@deal.product.user.name}", chatroom: @chatroom )
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
    Message.create(user: current_user, content: "✓ #{current_user.name} HAS APPROVED YOUR DEAL REQUEST TO BUY \"#{@deal.product.title}\". THEY WILL NOW ARRANGE YOUR ORDER WITH YOU.", chatroom: @chat )

    @deal.status = 'in_process'

    @deal.save

    redirect_to @chat
  end

  def rejected
    @deal = Deal.find(params[:id])
    authorize @deal
    @chat = current_user.chat_with(@deal.user)
    Message.create(user: current_user, content: "X UNFORTUNATELY, #{current_user.name} HAS REJECTED YOUR DEAL REQUEST. YOUR ORDER CANNOT BE PROCESSED.", chatroom: @chat )

    @deal.status = 'rejected'

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
