class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!
  before_action :redirect_if_not_authorized_to_purchase

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(:post_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_not_authorized_to_purchase
    if user_signed_in?
      if current_user.id == @item.user.id || @item.sold?
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

end