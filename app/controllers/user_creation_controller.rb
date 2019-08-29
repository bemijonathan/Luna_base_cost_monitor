class UserCreationController < ApplicationController
  def create 
    worker = Worker.new(name: params[:name], email: params[:email], password: params[:password])
    if worker.save
     details = worker.slice(:name, :email)
      render json: {status: 'SUCCESS', message:'All Items', data:details},status: :ok
    else
      render json: {status: 'FAILED'}, status: :unprocessable_entity
    end 
  end 
end
