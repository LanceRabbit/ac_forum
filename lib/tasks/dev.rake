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
        role: "#{user_role}"
      )
    end
    puts " #{User.count} users data"
  end

  # reply
  task fake_reply: :environment do
    Reply.destroy_all
    puts " create fake comment data ..."
    Post.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts " #{Reply.count} comment data"
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