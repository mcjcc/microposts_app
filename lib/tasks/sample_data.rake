namespace :db do
  desc "Fill Database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
    admin = User.create!(name: "Example User",
                 email: "example@example.com", 
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    20.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
    end
end

def make_microposts
    users = User.all(limit: 6)
    10.times do 
        content = Faker::Lorem.sentence(5)
        users.each {|user| user.microposts.create!(content: content)}
    end
end


def make_relationships
    users = User.all
    user = users.first
    followed_users = users[2..10]
    followers = users[3..8]
    followed_users.each {|followed| user.follow!(followed)}
    followers.each { | follower| follower.follow!(user)}
end