class UserController < ApplicationController
  
  def index
    @data = "Venkat"
  end

  def create
    user = User.new(user_params)

    if user.present?
      render json: { message: 'User already registered' }, status: :conflict
    elsif user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
