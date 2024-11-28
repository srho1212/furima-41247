class PurchaseInformationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_informations_shipping_destination = PurchaseInformationsShippingDestination.new
  end

  def create
    @purchase_informations_shipping_destination = PurchaseInformationsShippingDestination.new(purchase_informations_params)
    if @purchase_informations_shipping_destination.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_informations_params
    params.require(:purchase_informations_shipping_destination).permit(:post_code, :shipping_prefecture_id, :municipality, :street_address, :building_name, :telephone).merge(user_id: current_user.id, item_id: @item.id,)
  end
end