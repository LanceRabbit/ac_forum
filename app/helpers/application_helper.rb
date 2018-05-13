module ApplicationHelper

  def show_edit(type, object)
    case type
    when "User"
      puts current_user.name
      puts object.name
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

end
