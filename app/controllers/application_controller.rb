class ApplicationController < ActionController::Base

    #このように書くことで、usernameとpasswordでのログインも可能になります。
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      added_attrs = [ :email, :icon_url, :user_name, :password, :password_confirmation ]
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:password])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:password_confirmation])
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end

    private

    # ログイン後のリダイレクト先
    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(User)
        hello_index_path
      else
        root_path
      end
    end

    
    # ログアウト後のリダイレクト先
    def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :admin_admin_user
        new_admin_admin_user_session_path
      else
        new_user_session_path
      end
    end

end
