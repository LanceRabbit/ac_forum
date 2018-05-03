class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
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
   
    if @post.save
      redirect_to root_path
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
   
  end

  def edit
    # before_action
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
      flash[:notice] = "post was successfully updated"
    else
      render :edit
      flash[:alert] = "post was failed to update"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image,  category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
