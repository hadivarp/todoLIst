module Api
  module V1
    class AuthenticationController < BaseController
      def login
        @user = ::User.find_by(email: params[:email]) || ::User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
          token = JWT.encode({user_id: @user.id}, Rails.application.secret_key_base)
          render json: {message: "Login successful", token: token}, status: :ok
        else
          render json: {message: "Invalid credentials"}, status: :unauthorized
        end
      end

      def logout
        @current_user = nil
        render json: { message: "Logout successful" }, status: :ok
      end

      def signup
        @user = ::User.new(user_params)
        if @user.save
          token = JWT.encode({user_id: @user.id}, Rails.application.secret_key_base)
          render json: { message: "User created successfully", token: token }, status: :ok
        else
          render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:authentication).permit(:username, :email, :password)
      end
    end
  end
end
