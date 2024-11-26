class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        current_user.present?
    end

    def require_login
        unless logged_in?
            redirect_to login_path, alert: "You must be logged in to do that."
        end
    end

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private

    def record_not_found
        redirect_to root_path, alert: "Resource not found or access denied."
    end
end
