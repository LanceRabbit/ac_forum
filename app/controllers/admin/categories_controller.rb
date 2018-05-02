class Admin::CategoriesController < Admin::BaseController
 
 
  def index
    @categories = Category.all
  end

  def update
    

  end

  def destroy

  end
end