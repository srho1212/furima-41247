class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]#, :destroy]
  before_action :set_item, only: [:edit, :update]#,:destroy]
  before_action :correct_user, only: [:edit, :update,] #:destroy]

  def set_item
    @item = Item.find(params[:id])
  end

  def correct_user
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
  end


  def index
    @items = Item.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
   end

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

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all.pluck(:name, :id) # カテゴリーの選択肢を配列で用意する
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit,status: :unprocessable_entity
    end
  end

  #def destroy
    #@item = Item.find(params[:id])
    #if @item.destroy
      #redirect_to root_path, notice: 'Item was successfully deleted.'
   # else
   #   redirect_to item_path(@item), alert: 'Failed to delete the item.'
   # end
  #end
  
  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :image, :price, :category_id, :status_id, 
     :delivery_day_id, :shipping_fee_id, :shipping_prefecture_id, :user_id)
  end
end



