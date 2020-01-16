require 'jwt'

class UserCreationController < ApplicationController
  
  def create 
    worker = Worker.new(name: params[:name], email: params[:email], password: params[:password])
    payload = worker.slice(:name, :email)
    payload[:stamp] = Date.today.hash
    token = assign_token(payload)
    worker.token = token
    if worker.save
     details = worker.slice(:name, :email, :token)
      render json: {status: 'SUCCESS', message:'All Items', data:details},status: :ok
    else
      render json: {status: 'FAILED'}, status: :unprocessable_entity
    end 
  end 

  def destroy
    worker = Worker.find(params[:id])
    worker[:token] = ''
    worker.save
    if worker.token == ''
      render json: {status: 'SUCCCES'}, status: :ok
    else
      render json: {status: 'FAILED'}, status: :unprocessable_entity
    end
  end

  def all 
    worker = Worker.all
    render json: {status: 'SUCCCES', workers: worker}, status: :ok
  end

  def login
    worker = Worker.find_by(email: params[:email])
    if worker.password == params[:password]
      payload = worker.slice(:name, :email)
      payload[:stamp] = Date.today.hash
      puts
      t = assign_token(payload)
      worker[:token] = t
      worker.save
      details = worker.slice(:name, :email, :token)
      render json: {status: 'SUCCESS', message:'All Items', data:details},status: :ok
    else
      render json: {status: 'FAILED'}, status: :unprocessable_entity
    end
  end 
  private

  def assign_token(payload)
    @hmac_secret = 'my$ecretK3y'
    token = JWT.encode payload, @hmac_secret, 'HS256'
    return token
  end 


end
