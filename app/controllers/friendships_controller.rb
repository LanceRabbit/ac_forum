class FriendshipsController < ApplicationController

  def create
    # 需要設定前端的 link_to，在發出請求時送進 friend_id
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
        flash[:notice] = "Successfully send out friendship request"
        redirect_back(fallback_location: root_path)
    else
        # 驗證失敗時，Model 將錯誤訊息放在 errors 裡回傳
        # 使用 errors.full_messages 取出完成訊息集合(Array)，串接 to_sentence 將 Array 組合成 String
        flash[:alert] = @friendship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
    end
  end

  def destroy
      if is_cancel?
        @friendship = current_user.friendships.find_by(user_id: current_user, friend_id: params[:friend_id])
        @friendship.destroy
      elsif is_ingore?
        @friendship = Friendship.find_by(user_id: params[:friend_id] , friend_id: current_user)
        @friendship.destroy
      else
        @friendship = current_user.friendships.find_by(user_id: current_user, friend_id: params[:friend_id])
        @friendship.destroy
        @friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user)
        @friendship.destroy
      end
      # @friendship.destroy
      flash[:norice] = "friendship destroyed"
      redirect_back(fallback_location: :back)
  end
 
  def accept
    @friendship = Friendship.find_by(user_id: params[:friend_id] , friend_id: current_user)
    @friendship.status = true
    @friendship.save!
    current_user.friendships.create!(friend_id: params[:friend_id], status: true)

    flash[:norice] = "accept the friendship"
    redirect_back(fallback_location: root_path)
  end


  private 

  def is_cancel?
    params[:type] == 'Cancel'
  end

  def is_ingore?
    params[:type] == 'Ingore'
  end

end
