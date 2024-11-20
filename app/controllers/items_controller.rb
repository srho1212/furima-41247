class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user # 出品者の情報を@userに格納
    @category = @item.category.name # カテゴリー情報を取得
    @status = @item.status.name # 商品の状態情報を取得
    @shipping_fee = @item.shipping_fee.name # 配送料情報を取得
    @shipping_prefecture = @item.shipping_prefecture.name # 配送料情報を
    @delivery_day = @item.delivery_day.name # 配送料情報を
    @item_price = @item.price # 配送料情報を
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

  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :image, :price, :category_id, :status_id, 
     :delivery_day_id, :shipping_fee_id, :shipping_prefecture_id, :user_id)
  end
end



