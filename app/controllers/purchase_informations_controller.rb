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
      :post_code, :shipping_prefecture_id, :municipality, :street_address, :building_name, :telephone
    ).merge(item_id: params[:item_id], user_id: current_user.id)
  end
end