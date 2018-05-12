class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    if @user
      @posts = @user.posts
    else 
      flash[:alert] =  "User does not Exist"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
      flash[:notice] =  "User was successfully updated"
    else
      render :edit
      flash[:alert] = "User was failed to update"
    end
  end

  private 

  def set_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    end
  end

  def user_params
    params.require(:user).permit(:name, :description, :avatar)
  end

end
