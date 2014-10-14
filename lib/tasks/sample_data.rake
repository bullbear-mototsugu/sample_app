# db:populateタスク(:dbはただの名前空間)
# namespace :db do
  # desc "Fill database with sample data"

  # # RakeタスクがUserモデルなどのローカルのRails環境にアクセスできるようにする
  # task populate: :environment do
    # # User.create!は失敗したときにfalseではなく例外を発生させる

    # # 最初のユーザデータ
    # User.create!(name: "Example User",
                 # email: "example@railstutorial.jp",
                 # password: "foobar",
                 # password_confirmation: "foobar",
                 # admin: true)

    # # 残り99人分のダミーデータ
    # 99.times do |n|
      # name  = Faker::Name.name
      # email = "example-#{n+1}@railstutorial.jp"
      # password  = "password"
      # User.create!(name: name,
                   # email: email,
                   # password: password,
                   # password_confirmation: password)
    # end


    # # 最初の6人だけ50回つぶやいているデータ
    # # users = User.all(limit: 6)
    # users = User.all.limit(6)
    # 50.times do
      # content = Faker::Lorem.sentence(5)
      # users.each { |user| user.microposts.create!(content: content) }
    # end
  # end
# end

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.jp",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.jp"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  # users = User.all(limit: 6)
  users = User.all.limit(6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

