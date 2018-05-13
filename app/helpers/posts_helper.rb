module PostsHelper

  def show_edit(reply)
    if reply.user == current_user 
      return true
    else
      return false
    end
  end
  
  def collect_btn(post)
    if post.is_collected?(current_user)
      link_to 'Uncollect', uncollect_post_path(post), data: { disable_with: "Please wait..." }, method: :post, class: "btn btn-danger btn-xs m-1" 
    else 
      link_to 'Collect', collect_post_path(post), data: { disable_with: "Please wait..." }, method: :post, class: "btn btn-primary btn-xs m-1" 
    end
  end
end
