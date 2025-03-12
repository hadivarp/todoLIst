module Api
module V1
  class BaseController < ApplicationController
    # API-specific configurations
    protect_from_forgery with: :null_session
    
    # Handle CSRF token for API requests
    skip_before_action :verify_authenticity_token, if: :json_request?
    
    # Add authentication for API controllers
    before_action :authenticate_user
    
    # Helper method to check if request is JSON
    def json_request?
      request.format.json? || request.content_type =~ /\Aapplication\/json\b/
    end
    
    # Respond with JSON for API errors
    rescue_from ActionController::ParameterMissing do |exception|
      render json: { error: exception.message }, status: :bad_request
    end
  end
end
end
