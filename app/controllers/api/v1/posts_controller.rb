class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index
  def index
    @posts = Post.published(Post::All)
    render json: {
      data: @posts.map do |post|
        {
          title: post.title,
          replies_count: post.replies_count,
          views_count: post.views_count,
          last_replied: post.last_replied
         }
       end
    }
  end
  def show 
    @post = Post.find_by(id:params[:id])
    if @post.level == Post::All ||
      @post.user == current_user || 
      current_user.admin? ||
      @post.user.is_friend?(current_user)
      render json: {
        data: @post
      }
    else
      render json: {
        message: "閱讀權限不足"
      }
    end
  end
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: {
        message: (@post.published ? 'Post' : 'Draft') + " was successfully created",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    @post = Post.find_by(id:params[:id])
    if @post.user == current_user || current_user.admin?
      if @post.update(post_params)
        @post.save
        render json: {
          message: (@post.published ? 'Post' : 'Draft') + " was successfully created",
          result: @post
        }
      else
        render json: {
          errors: @post.errors
        }
      end
    else
      render json: {
          errors: "權限不足進行修改"
        }
    end
  end

  def destroy
    @post = Post.find_by(id:params[:id])
    if @post.user == current_user || current_user.admin?
      @post.destroy
      render json: {
        message: (@post.published ? 'Post' : 'Draft') + " was successfully deleted",
      }
    else
      render json: {
        message: "權限不足進行修改"
      }
    end
  end


  private

  def post_params
    params.permit(:title, :content, :image, :level, category_ids:[])
  end
end
