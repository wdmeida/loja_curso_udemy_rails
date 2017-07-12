class Members::RegistrationsController < Devise::RegistrationsController
  
  before_filter :configure_permited_parameters

  # GET /members/sign_up
  def new
    build_resource({})
    resource.build_profile_member
    respond_with self.resource  
  end

  protected

    def configure_permited_parameters
      devise_parameter_sanitizer.permit(:sign_up, :keys => [
          :email, :password, :password_confirmation,
          :profile_member_attributes => [:first_name, :second_name]
        ]
      )
    end
end
