module PostsHelper
  
  def collect_btn(post)
    if post.is_collected?(current_user)
      link_to "Uncollect", uncollect_post_path(post),  method: :post, remote: true, id: "uncollect-#{post.id}", class: "btn btn-danger btn-xs m-1 uncollect-btn" 
    else 
      link_to "Collect", collect_post_path(post),  method: :post, remote: true,id: "uncollect-#{post.id}", class: "btn btn-primary btn-xs m-1 collect-btn" 
    end
  end
end
