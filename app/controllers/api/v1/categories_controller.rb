module Api
  module V1
    class CategoriesController < BaseController
      before_action :set_category, only: [:show, :update, :destroy]

      def index
        @categories = @current_user.categories
        render json: { categories: @categories }, status: :ok
      end

      def show
        render json: @category
      end

      def create
        @category = @current_user.categories.new(category_params)
        if @category.blank?
          render json: { message: @category.errors.full_messages }, status: :unprocessable_entity
        elsif @category.save
          render json: { message: "Category created successfully" }, status: :ok
        else
          render json: { message: @category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @category.nil?
          render json: { message: "Category not found" }, status: :not_found
        elsif @category.update(category_params)
          render json: { message: "Category updated successfully" }, status: :ok
        else
          render json: { message: @category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.nil?
          render json: { message: "Category not found" }, status: :not_found
        elsif @category.deleted_at.present?
          render json: { message: "Category is already deleted" }, status: :unprocessable_entity
        elsif @category.update(deleted_at: Time.now)
          render json: { message: "Category deleted successfully" }, status: :ok
        end
      end

      private

      def category_params
        params.permit(:name)
      end

      def set_category
        @category = ::Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { message: "Category not found" }, status: :not_found
      end
    end
  end
end
