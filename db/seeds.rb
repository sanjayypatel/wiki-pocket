user = User.new(
  username: "admin",
  email: "admin@example.com",
  password: 'helloworld',
  role: 'admin'
  )
user.skip_confirmation!
user.save!

user = User.new(
  username: "premium",
  email: "premium@example.com",
  password: 'helloworld',
  role: 'premium'
  )
user.skip_confirmation!
user.save!

user = User.new(
  username: "member",
  email: "member@example.com",
  password: 'helloworld'
  )
user.skip_confirmation!
user.save!

7.times do |n|

  user = User.new(
    username: "user#{n}",
    email: "email#{n}@example.com",
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

20.times do |n|

  wiki = Wiki.new(
    title: "Wiki Title #{n}",
    body: Faker::Lorem.paragraph(10),
    private: false,
    user: users.sample
    )
  wiki.save!

end

puts "Finished Seeding."
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."