class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy]

  def index
    @item = Item.all
    render json: {status: 'SUCCESS', message:'All Items', data:@item},status: :ok
  end

  def create 
    @create_item = Item.new(item_params)
    if @create_item.save
      render json: @create_item, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def destroy 
    @item.destroy
    if @item.destroyed?
      render json: {status: 'SUCCESS', message:'destroyed Items'},status: :ok
    else
      render json: {status: 'SUCCESS', message:'unable to delete Items'},status: :ok
    end 
  end

  private 

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:category,:amount,:transaction_status,:name)
  end 

end
