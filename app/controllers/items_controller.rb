class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end



  private

  def item_params
    params.require(:item).permit(:item_name, :item_descriptiondescription, :price, :category_id, :status_id, :delivery_day_id, :shipping_fee_id, :shipping_prefecture_id)
  end
end


