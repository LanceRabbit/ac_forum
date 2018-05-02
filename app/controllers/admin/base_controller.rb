class Admin::BaseController < ApplicationController
  # 後台權限驗證
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not Allow"

      redirect_to root_path
    end
  end
end