class Users::RegistrationsController < Devise::RegistrationsController
  # before_filter :check_permissions, :only => [:new, :create, :cancel]
  #   skip_before_filter :require_no_authentication
  before_filter :configure_permitted_parameters
  
  # 
  # def check_permissions
  #   authorize! :create, resource
  # end
 
  protected
  
  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :address, :email, :office, :tel, :mobile, :busines_name, :position, :alert_submited_on_time, :alert_awaiting_approval, :password, :password_confirmation, :current_password)
    end
  end
 
end