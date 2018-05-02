class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:update]


  def index
    @users = User.all

    if params[:id]
      set_user
    else
      @category = Category.new
    end
  end

  def update

    if @user.update(user_params)
      redirect_to admin_users_path(@user)
      flash[:notice] = "user was successfully updated"
    else
      redirect_to admin_users_path
      flash[:alert] = "user was failed to update"
    end

  end

  private 
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:role)
    end

end