class PurchaseInformationsController < ApplicationController
  before_action :authenticate_user!  # すべてのアクションで認証を要求
  before_action :set_item, only: [:index, :create]
  before_action :deny_access_if_sold_or_owner, only: [:index, :create]
  
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_informationsform = PurchaseInformationsForm.new
  end
  
  def create
    @purchase_informationsform = PurchaseInformationsForm.new(purchase_informations_params)
    if @purchase_informationsform.valid?
      pay_item
      @purchase_informationsform.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_item
    @item = Item.find(params[:item_id])
  end
  
  def deny_access_if_sold_or_owner
    if @item.purchase_information.present? || @item.user_id == current_user.id
      redirect_to root_path, alert: 'この商品は購入できません。'
    end
  end
  
  def purchase_informations_params
    params.require(:purchase_informations_form).permit(
      :post_code, :shipping_prefecture_id, :municipality, :street_address, :building_name, :telephone
    ).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_informations_params[:token],
      currency: 'jpy'
    )
  end
end