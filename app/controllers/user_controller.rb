class UserController < ApplicationController
  def index
    @current_time = Time.current.in_time_zone("Asia/Kolkata")
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      render json: { id: user.id, name: user.name, email: user.email }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
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
