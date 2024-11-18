class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    #@items = Item.all
  end

  #def show
   # @item = Item.find(params[:id])
  #end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new,status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :image, :price, :category_id, :status_id, 
     :delivery_day_id, :shipping_fee_id, :shipping_prefecture_id, :user_id)
  end
end



