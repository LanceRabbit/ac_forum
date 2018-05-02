module ApplicationHelper

  def show_navtabs(tab)
    if ((current_page?(admin_users_path) && tab == 'users') || 
      (current_page?(admin_categories_path) && tab == 'categories'))
      return 'nav-link active'
    end
    return 'nav-link'
  end
end
