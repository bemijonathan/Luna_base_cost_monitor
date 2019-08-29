class SessionsController < ApplicationController
  
    def create
     worker = Worker.where(email: params[:email]).first
  
      if worker.valid_password?(params[:password])
        puts "##############"
        render json: @worker.as_json(only: [:id, :email]),status: :ok
      else
        render json: {status: 'SUCCESS'}, status: :unprocessable_entity
        puts "##"
      end
  
    end
  
    def destroy
      
    end
end
