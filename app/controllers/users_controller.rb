class UsersController < ApplicationController
  before_action :authenticate_user!
  include AvatarHelper
  def index
      @users = User.all
      @user = current_user
  end

  def show
    current_user.admin ? @user = User.find(params[:id]) : @user = User.find(current_user.id)
  end
  
  def edit
  end
  n=0
  def change_pic
    id = params[:id]
    user = User.find(id)
    create_avatar(user.id)
    file = "tmp/#{user.id}.png"
    user.pic = BSON::Binary.new(File.read(file))
    user.update
    FileUtils.rm(file) if File.exist?(file)
    respond_to do |format|
      format.js
    end
  end

  def update
   current_user.admin ? @user = User.find(params[:id]) : @user = User.find(current_user.id)
   # @user.avatar = create_avatar(@user.id)
   respond_to do |format|
    if @user.update(user_params)
      format.html { redirect_to  users_path, notice: "#{@user.name} was successfully updated." }
    else
      format.html { render :edit }
    end
  end
end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
    end
  end

  private
  def user_params
    params.require(:user).permit(:pic, :name, :email, :admin, :password, :password_confirmation, :fname, :lname, :b_date, :post)
  end

end
