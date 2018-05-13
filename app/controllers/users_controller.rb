class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
      @users = User.all
      @user = current_user
  end

  def show
    current_user.admin ? @user = User.find(params[:id]) : @user = User.find(current_user.id)
  end
  
  def edit
  end

  def update
   current_user.admin ? @user = User.find(params[:id]) : @user = User.find(current_user.id)
   @user.avatar = create_avatar(@iser.id)
   respond_to do |format|
    if @user.update(user_params)
      format.html { redirect_to  users_path, notice: "#{@user.name} was successfully updated." }
      format.json { render :show, status: :ok, location:  users_path }
    else
      format.html { render :edit }
      format.json { render json:  users_path.errors, status: :unprocessable_entity }
    end
  end
end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:avatar, :admin, :password, :password_confirmation)
  end

end
