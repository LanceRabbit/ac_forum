require 'rails_helper'

RSpec.describe 'feeds', type: :request do
  include PostsHelper

  describe "GET Feeds" do
    before do
      create_user_list
      create_posts_list
      create_replies_list
      get feeds_path
    end

    it 'can render index' do
      expect(response).to render_template(:index)
    end

    it "check we have user count info in view template" do

      user_count = User.all.count
      post_count = Post.all_published.count
      reply_count = Reply.all.count
      # 測試

      expect(assigns(:user_count)).to eq 15
      expect(assigns(:post_count)).to eq 5
      expect(assigns(:reply_count)).to eq 5
    end

  end
end