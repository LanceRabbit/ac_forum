class PostsController < ApplicationController
  # except 排除首頁檢核使用者登入
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    # @posts = Post.published.where('level <= ?', 2).page(params[:page]).per(20)
    # 包含到 all/friend可看到的文章
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @ransack = @category.posts.published(2).ransack(params[:q])
    else
      @ransack = Post.published(2).ransack(params[:q])
    end 

    @posts = @ransack.result(distinct: true).page(params[:page]).per(20)
  end

  def new
    if current_user.nil?
      redirect_to new_user_session_path
    else    
      @post = Post.new
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if published?
      @post.published = true
    else
      @post.published = false
    end
 
    if @post.save
      flash[:notice] =  (@post.published ? 'Post' : 'Draft') + " was successfully created"
      redirect_to root_path
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end
  
  def show 
    @replies = @post.replies.page(params[:page]).per(20)
    @reply = Reply.new
    @post.views_count +=1
    @post.save! 
  end
  def edit
    # before_action
  end

  def update
    if published?
      @post.published = true
    else
      @post.published = false
    end

    if @post.update(post_params)
      redirect_to post_path
      flash[:notice] =  (@post.published ? 'Post' : 'Draft') + " was successfully updated"
    else
      render :edit
      flash[:alert] = "post was failed to update"
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
    flash[:notice] =  (@post.published ? 'Post' : 'Draft') + " was successfully destroied"
  end


  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :level, category_ids: [])
  end

  def published?
    params[:commit] == 'Submit'
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
