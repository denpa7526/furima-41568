class ItemsController < ApplicationController

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_info, :category_id, :condition_id, :shopping_fee_id, :prefecture_id,
                                 :delivery_time_id, :price, :image).merge(user_id: current_user.id)
  end
end
