class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name,:last_name, :email, :password) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password) }
        end

    def ensure_signup_complete
      return if action_name == 'finish_signup'

      if current_user && !current_user.email_verified?
        redirect_to finish_signup_path(current_user)
      end
    end

end
