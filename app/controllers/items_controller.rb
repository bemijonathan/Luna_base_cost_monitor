require 'jwt'

class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy]

  def index
    @item = Item.all
    render json: {status: 'SUCCESS', message:'All Items', data: @item},status: :ok
  end

  def create 
      token = request.headers['auth']
      hmac_secret = 'my$ecretK3y'
      decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
    if decoded_token
        current_user = Worker.where(token: token).first
        @item = current_user.items.build(item_params)
        if @item.save
          render json: @item, status: :ok
        else
          render status: :unprocessable_entity
        end
      else
    end
  end

  def destroy 
    token = request.headers['auth']
    user_id = Worker.where(token: token).first.id
    if @item.worker_id === user_id
      @item.destroy
    end
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
