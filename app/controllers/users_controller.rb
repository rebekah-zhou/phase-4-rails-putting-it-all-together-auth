class UsersController < ApplicationController
    def create 
        user = User.create(user_params)
        session[:user_id] = user.id 
        render json: user, status: :created 
    rescue ActiveRecord::InvalidRecord => invalid 
        render json: { errors: invalid.errors.full_message }, status: :unprocessable_entity
    end

    def show 
        user = User.find_by(id: session[:user_id])
        if user 
            render json: user 
        else 
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation, :bio, :image_url)
    end
end
