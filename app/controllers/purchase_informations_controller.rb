class PurchaseInformationsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def create
    @purchase_informations = PurchaseInformation.create(purchase_informations_params)
    Shipping_Destination.create(shipping_destinations_params)
    redirect_to root_path
  end

  private

  def purchase_informations_params
    params.permit(:price).merge(user_id: current_user.id)
  end

  def shipping_destinations_params
    params.permit(:post_code, :shipping_prefecture_id, :municipality, :street_address, :building_name,:telephone ).merge(purchase_informations_id: @purchase_informations.id)
  end
end
  
