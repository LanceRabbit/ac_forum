namespace :dev do

  # user
  task fake_user: :environment do
    #User.destroy_all
    puts " create fake users data ..."
    20.times do |i|
      user_name = FFaker::Name.first_name
      user_role = i%2 == 0 ? 'admin' : 'normal'
      User.create!(
        email: "#{user_name}@example.com",
        password: "12345678",
        name: "#{user_name}",
        description: FFaker::Lorem::sentence(30),
        role: "#{user_role}"
      )
    end
    puts " #{User.count} users data"
  end

  task fake_post: :environment do 
    #Post.destroy_all
    puts " create fake post data ..."
    User.all.each do |user|
      rand(3..6).times do |i|
        published = [true, false].sample
        Post.create!(
          title: FFaker::Book::title,
          user_id: user.id,
          content: FFaker::Lorem::sentence(30),
          level: rand(1..3),
          published: "#{published}"
        )
      end
      puts "#{Post.count} posts data"
    end
  end

  task fake_categroy: :environment do 
    PostCategory.destroy_all
    puts " set the categroy of posts ..."
    Post.all.each do |post|
      post.post_categories.create!(category: Category.all.sample)
    end
    puts "#{PostCategory.count} PostCategory data"
  end

  task fake_friend: :environment do 
    Friendship.destroy_all
    User.all.each do |user|
      User.all.sample(2).each do |friend_user|
        if user != friend_user
          puts user.id 
          puts friend_user.id 
          if !user.is_friend?(friend_user)
            Friendship.create!(user_id: user.id ,friend_id: friend_user.id, status: true)
            Friendship.create!(user_id: friend_user.id ,friend_id: user.id, status: true)
          end
        end
      end
    end
    puts "now have #{Friendship.count} friendships"
  end

  # reply
  task fake_reply: :environment do
    #Reply.destroy_all
    puts " create fake reply data ..."
    Post.all.sample(30).each do |post|
      3.times do |i|
        user = post.user.friends.sample
        post.replies.create!(
          comment: FFaker::Lorem.sentence,
          user: user
        )
      end
    end
    puts " #{Reply.count} replies data"
  end

  task fake_collection: :environment do
    Collection.destroy_all
    Post.all.sample(30).each do |post|
      3.times do |i|
        user = post.user.friends.sample
        post.collections.create!(user: user)
      end
    end
    puts "#{Collection.count} Collection data"
  end


  #fake all data
  task fake_all: :environment do
    # Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_friend'].execute
    Rake::Task['dev:fake_post'].execute
    Rake::Task['dev:fake_categroy'].execute
    Rake::Task['dev:fake_collection'].execute
    Rake::Task['dev:fake_reply'].execute
  end
end