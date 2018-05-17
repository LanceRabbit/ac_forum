require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association' do
    it { should have_many(:replies) }
    it { should have_many(:posts) }
    it { should have_many(:collections) }
    it { should have_many(:friendships) }
  end

  describe 'Validation' do
    subject { FactoryBot.create(:user) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end

  it "should count all user" do
    expect(User.get_user_count).to eq(0)
    create(:user)
    expect(User.get_user_count).to eq(1)
  end

  it "should count all replies by this user" do
    user = create(:user)
    expect(user.get_post_count).to eq(0)
    post = create(:post)
    user.posts << post
    expect(user.get_post_count).to eq(1)
  end

end