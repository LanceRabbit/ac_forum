class FeedsController < ApplicationController
  def index
    @user_count = User.all.count
    @post_count = Post.all_published.count
    @reply_count = Reply.all.count
    @users = User.all.order(replies_count: :desc).limit(10)
    @posts = Post.all.order(replies_count: :desc).limit(10)
  end
end
