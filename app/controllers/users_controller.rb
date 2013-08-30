class UsersController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]
  def index
    @users = User.all
  end
  
  def new
    @user_type = params[:user][:user_type] if params[:user]

    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.password = "123456789"

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render json: users_path, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
    render :action => "../users/edit"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Saved"
      redirect_to users_path
    else
      flash[:error] = "Not Saved"
      render :action => "new"
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :office, :address, :tel, :mobile, :business_name, :position, :alert_submited_on_time, :alert_awaiting_approval, :type, :role_id)
  end


  
end