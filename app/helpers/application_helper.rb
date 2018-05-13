module ApplicationHelper

  def show_edit(type, object)
    case type
    when "User"
      if object == current_user 
        return true
      else
        return false
      end
    when "Friend"
      if object == current_user 
        return false
      else
        return true
      end
    when "Post", "Reply"
      if object.user == current_user 
        return true
      elsif type == 'Post' && current_user.admin?
        return true
      else
        return false
      end
    else
      return false
    end
  end


  def friend_button(user)
    if current_user.is_friend?(user) 
      return link_to 'UnFriend', friendship_path(friend_id: user, type: "Delete"), method: :delete, data: { confirm: "Are you sure?"}, class: 'btn btn-danger m-1' 
    elsif current_user.invitee_friend?(user) 
      return link_to 'Cancel', friendship_path(friend_id: user, type: "Cancel"), method: :delete, data: { confirm: "Are you sure?"}, class: 'btn btn-danger m-1' 
    elsif current_user.inviter_friend?(user)
      return (link_to 'Accept', accept_friendship_path(friend_id: user), method: :post, class: 'btn btn-success m-1') +
      "<br>".html_safe +  (link_to 'Ingore', friendship_path(friend_id: user, type: "Ingore"), method: :delete, data: { confirm: "Are you sure?"}, class: 'btn btn-danger m-1') 
     elsif user != current_user 
      return link_to 'Friend', friendships_path(friend_id: user), method: :post, class: 'btn btn-primary' 
     end 
  end
  
end
