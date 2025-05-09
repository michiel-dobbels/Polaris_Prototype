# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    
    private

      def split_full_name
        return unless params[:user][:full_name].present?

        full_name = params[:user].delete(:full_name)
        name_parts = full_name.strip.split

        params[:user][:first_name] = name_parts.first
        params[:user][:last_name] = name_parts[1..].join(" ") # Handle multi-part last names
    end
    protected
  
    # Allow extra fields to be permitted
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :bio, :profile_image, :cover_image])
      devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :bio, :profile_image, :cover_image])
    end
  
    # Skip password requirement on account update
    def update_resource(resource, params)
      resource.update_without_password(params)
    end
  end
  
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
