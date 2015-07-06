# Specific Users
user = User.new(
  username: "admin",
  email: "admin@example.com",
  password: 'helloworld',
  role: 'admin'
  )
user.skip_confirmation!
user.save!

premium = User.new(
  username: "premium",
  email: "premium@example.com",
  password: 'helloworld',
  role: 'premium'
  )
premium.skip_confirmation!
premium.save!

user = User.new(
  username: "member",
  email: "member@example.com",
  password: 'helloworld'
  )
user.skip_confirmation!
user.save!

# Seed Users
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
standard_users = User.where(role: 'standard')

# Seed Wikis
20.times do |n|

  wiki = Wiki.new(
    title: "Wiki Title #{n}",
    body: Faker::Lorem.paragraph(10),
    private: false,
    user: users.sample
    )
  wiki.save!

end
wikis = Wiki.all

# Seed Private Wikis
5.times do |n|

  wiki = premium.wikis.build(
    title: "Private Wiki Title #{n}",
    body: Faker::Lorem.paragraph(10),
    private: true
  )
  wiki.save!

end
private_wikis = Wiki.where(private: true)

# Seed Collaborations
5.times do 
  collaboration = Collaboration.new(
    wiki: private_wikis.sample,
    user: standard_users.sample
  )
  collaboration.save!

end

puts "Finished Seeding."
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."