class UsersController < Devise::RegistrationsController
  def index
    @users = User.all
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
    params.require(:user).permit(:role_id)
  end


  
end