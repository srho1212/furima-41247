class PurchaseInformationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_item, only: [:index, :create]

  def index
    #@item = Item.find(params[:item_id])
    @purchase_informationsform = PurchaseInformationsForm.new
  end

  def create
    @purchase_informationsform = PurchaseInformationsForm.new(purchase_informations_params)
    if @purchase_informationsform.valid?
      pay_item
      @purchase_informationsform.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_informations_params
    params.require(:purchase_informations_form).permit(
      :post_code, :shipping_prefecture_id, :municipality, :street_address, :building_name, :telephone).merge(item_id: params[:item_id], user_id: current_user.id,token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_ee29726f757bb33bd9c5f5ea"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_informations_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
