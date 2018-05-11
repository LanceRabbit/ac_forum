class RepliesController < ApplicationController
  before_action :set_post, only: [:create, :update, :destroy, :edit]
  before_action :set_reply, only: [:update, :destroy, :edit]
  def create 
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      redirect_to post_path(@post)
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_to post_path(@post)
    end
  end
  
  def edit 

  end

  def update 
    if @reply.update(reply_params)
      redirect_to post_path(@post)
      flash[:notice] = "restaurant was successfully updated"
    else
      render :edit
      flash[:alert] = "restaurant was failed to update"
    end
  end

  def destroy 
    @reply.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
