module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: @user
      end

      # Commented create action - uncomment if needed
      # def create
      #   @user = User.new(user_params)
      #   if @user.save
      #     render json: { message: "User created successfully" }, status: :ok
      #   else
      #     render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
      #   end
      # end

      def update
        if @user.nil?
          render json: { message: "User not found" }, status: :not_found
        elsif @user.update(user_params)
          render json: { message: "User updated successfully" }, status: :ok
        else
          render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.nil?
          render json: { message: "User not found" }, status: :not_found
        elsif @user.deleted_at.present?
          render json: { message: "User is already deleted" }, status: :unprocessable_entity
        elsif @user.update(deleted_at: Time.now)
          render json: { message: "User deleted successfully" }, status: :ok
        end
      end

      private

      def user_params
        params.permit(:username, :email, :password)
      end

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { message: "User not found" }, status: :not_found
      end
    end
  end
end
