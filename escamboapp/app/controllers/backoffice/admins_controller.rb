class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:destroy, :edit, :update]
  
  # Ensuring policies and scoped are used.  
  after_action :verify_authorized, only: [:destroy, :new]
  after_action :verify_policy_scoped, only: [:index]

  def index
    # @admins = Admin.all
    # @admins = Admin.with_restricted_access
    @admins = policy_scope(Admin)
  end

  def new
  	@admin = Admin.new
    # Call Pundit Authotization
    authorize @admin
  end

  def create
  	@admin = Admin.new(params_admin)
  	
  	if @admin.save
  		redirect_to backoffice_admins_path, notice: I18n.t('messages.created_with', :item => @admin.email)
  	else
  		render :new
  	end
  end

  def edit
  end

  def update

  	if @admin.update(params_admin)      
      # Lembrar de alterar depois para executar com um background job.
      AdminMailer.update_email(current_admin, @admin).deliver_now
  		redirect_to backoffice_admins_path, notice: I18n.t('messages.updated_with', :item => @admin.email)
  	else
  		render :edit
  	end
  end

  def destroy
    authorize @admin
    admin_email = @admin.email

    if @admin.destroy
      redirect_to backoffice_admins_path, notice: I18n.t('messages.destroyed_with', :item => @admin.email)
    else
      render :index
    end
  end

  private

	  def set_admin
	  	@admin = Admin.find(params[:id])
	  end

	  def params_admin
      passwd = params[:admin][:password]
      passwd_confirmation = params[:admin][:password_confirmation]

      if passwd.blank? && passwd_confirmation.blank?
        params[:admin].except!(:password, :password_confirmation)
      end
	  	
      params.require(:admin).permit(policy(@admin).permitted_attributes)
	  end
end
