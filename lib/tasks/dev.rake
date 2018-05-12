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
  # reply
  task fake_reply: :environment do
    #Reply.destroy_all
    puts " create fake reply data ..."
    posts = Post.where("level <= ?", 1)
    posts.each do |post|
      3.times do |i|
        post.replies.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts " #{Reply.count} replies data"
  end

  task test: :environment do
    #Reply.destroy_all
    #  User.where.not(role: "admin").destroy_all
    puts " create fake reply data ..."
    posts = Post.where("level <= ?", 1)
    posts.each do |post|
      puts post.title
      3.times do |i|
        post.replies.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts " #{Reply.count} replies data"
  end
  


  #fake all data
  task fake_all: :environment do
    # Rake::Task['db:drop'].execute
    # Rake::Task['db:migrate'].execute
    # Rake::Task['db:seed'].execute
    # Rake::Task['dev:fake_restaurant'].execute
    # Rake::Task['dev:fake_user'].execute
    # Rake::Task['dev:fake_comment'].execute
    # Rake::Task['dev:fake_favorite'].execute
    # Rake::Task['dev:fake_like'].execute
  end
end