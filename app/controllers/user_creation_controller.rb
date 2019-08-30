require 'jwt'

class UserCreationController < ApplicationController
  # 

  def create 
    worker = Worker.new(name: params[:name], email: params[:email], password: params[:password])

    hmac_secret = 'my$ecretK3y'

    payload = worker.slice(:name, :email)

    token = JWT.encode payload, hmac_secret, 'HS256'

    puts token

    worker.token = token

    if worker.save
     details = worker.slice(:name, :email, :token)

      render json: {status: 'SUCCESS', message:'All Items', data:details},status: :ok
    else
      render json: {status: 'FAILED'}, status: :unprocessable_entity
    end 

  end 

      # decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }

    # puts decoded_token


  # def update
  #   worker = Worker.find(params[:id])

  #   params[:name]? worker.name = params[:name] : null


  # end

  def destroy
    worker = Worker.find(params [:id])
    worker.destroy
    if worker.destroyed?
      render json: {status: 'SUCCCES'}, status: :ok
    else
      render json: {status: 'FAILED'}, status: :unprocessable_entity
    end
  end

end
