require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_posts', role: 'normal') }
  let(:user_with_posts) { create(:user_with_posts, name: 'user_with_posts') }
  # let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets') }
  # let(:user_with_tweets) { create(:user_with_tweets, name: 'user_with_tweets') }
  let(:category1) { create(:category) }
  let(:post) { create(:post, user: user_with_posts) }
  let(:post1) { create(:post, user: user) }
  let(:post2) { create(:post, user: user) }
  let(:post3) { create(:post, user: user) }
  let(:post4) { create(:post, user: user) }
  # let(:tweet2) { create(:tweet, user: user_with_tweets) }
  # let(:tweet3) { create(:tweet, user: user) }
  # let(:tweet4) { create(:tweet, user: user_with_tweets) }
  # let(:tweet5) { create(:tweet, user: user) }
  # let(:reply) { create(:reply, user: user, tweet: tweet) }


  context '#show' do
    before do
      user_with_posts
      category1
      sign_in(user_with_posts)
    end

    describe 'go to current_user page' do
      it 'will show current users tweets' do
        get user_path(user_with_posts)
        expect(assigns(:posts)).to eq controller.current_user.posts
      end
    end
    describe 'go to other user page' do
      it 'will show current users tweets' do
        get user_path(user)
        expect(assigns(:posts).count).to eq 0
        # user.posts.create(title: 'test', content: '123', level: 1, published: true)
         
        post = create(:post, :with_category)
        user.posts << post
        get user_path(user)
        expect(assigns(:posts).count).to eq 1
      end
    end
  end

  context '#edit' do
    before do
      user_with_posts
      sign_in(user_with_posts)
    end

    describe 'go to edit page' do
      it 'will render edit page' do
        get edit_user_path(user_with_posts)
        expect(response).to render_template(:edit)
      end

      it 'will redirect if not this user' do
        get edit_user_path(user)
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

end