module Api
  module V1
    class TasksController < BaseController
      before_action :set_task, only: [:show, :update, :destroy]

      def index
        @tasks = @current_user.tasks
        render json: @tasks
      end

      def show
        render json: @task
      end

      def create
        @task = @current_user.tasks.new(task_params)
        if @task.save
          render json: { message: "Task created successfully"}, status: :ok
        else
          render json: { message: @task.errors.full_messages}, status: :unprocessable_entity
        end
      end

      def update
        if @task.nil?
          render json: { message: "Task not found" }, status: :not_found
        elsif @task.update(task_params)
          render json: { message: "Task updated successfully" }, status: :ok
        else
          render json: { message: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      def destroy
        if @task.nil?
          render json: { message: "Task not found" }, status: :not_found
        elsif @task.deleted_at.present?
          render json: { message: "Task is already deleted" }, status: :unprocessable_entity
        elsif @task.update(deleted_at: Time.now)
          render json: { message: "Task deleted successfully" }, status: :ok
        end
      end

      private

      def task_params
        params.permit(:title, :description, :priority, :status, :start_date, :end_date, :due_date, :category_id)
      end

      def set_task
        @task = ::Task.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { message: "Task not found" }, status: :not_found
      end


    end
  end
end
