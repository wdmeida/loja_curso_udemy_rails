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
  	update_roles

  	if @admin.save
  		redirect_to backoffice_admins_path, notice: I18n.t('messages.created_with', :item => @admin.email)
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
    update_roles

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

    def remove_all_roles
      Role.availables.each do |role|
        @admin.remove_role(role)
      end
    end

    def update_roles
      remove_all_roles
      roles = params[:admins].extract!(:role_ids)
      roles[:role_ids].each do |role|
        @admin.add_role(role)
      end
    end

	  def set_admin
	  	@admin = Admin.find(params[:id])
	  end

	  def params_admin
      if password_blank?
        params[:admin].except!(:password, :password_confirmation)
      end
	  	
      if @admin.blank?
        params.require(:admin).permit(:name, :email, :role, :password, :password_confirmation)
	    else
        params.require(:admin).permit(policy(@admin).permitted_attributes)       
      end
    end

    def password_blank?
      params[:admin][:password].blank? && 
      params[:admin][:password_confirmation].blank?
    end
end
