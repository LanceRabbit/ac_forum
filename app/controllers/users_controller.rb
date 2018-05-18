class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :drafts, :replies, :collections, :friends]

  def show
    if @user
      @posts = @user.posts.all_published
    else 
      flash[:alert] =  "User does not Exist"
      redirect_to root_path
    end
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
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

  def replies
    if @user
      @replies = @user.replies
    else 
      flash[:alert] =  "User does not Exist"
      redirect_to root_path
    end
  end

  def collections
    if @user
      @collections = @user.collections
    else 
      flash[:alert] =  "User does not Exist"
      redirect_to root_path
    end
  end

  def drafts
    if @user
      @posts = @user.posts.all_draft
    else 
      flash[:alert] =  "User does not Exist"
      redirect_to root_path
    end
  end

  def friends
    if @user
      @friends = @user.friends
      @inviter_friends = @user.inviter_friends
      @invitee_friends = @user.invitee_friends
    else 
      flash[:alert] =  "User does not Exist"
      redirect_to root_path
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
