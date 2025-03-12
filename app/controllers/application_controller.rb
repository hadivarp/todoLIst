class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # For APIs, use null_session instead of exception
  protect_from_forgery with: :null_session
  
  def authenticate_user
    return if controller_path == 'api/v1/authentication'
    
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    
    begin
      if token
        decoded = JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: 'HS256' })[0]
        @current_user = ::User.find(decoded["user_id"])
      end
    rescue JWT::DecodeError => e
      render json: { message: "Invalid token" }, status: :unauthorized
      return
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: "User not found" }, status: :unauthorized
      return
    end
    
    unless @current_user
      render json: { message: "Unauthorized" }, status: :unauthorized
    end
  end
  
  def current_user
    @current_user
  end
end
