# Specific Users
user = User.new(
  username: "admin user",
  email: "admin@example.com",
  password: 'helloworld',
  role: 'admin'
  )
user.skip_confirmation!
user.save!

premium = User.new(
  username: "premium user",
  email: "premium@example.com",
  password: 'helloworld',
  role: 'premium'
  )
premium.skip_confirmation!
premium.save!

user = User.new(
  username: "member user",
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

# Seed Tags

10.times do

  word = Faker::Lorem.characters(5)
  tag = ActsAsTaggableOn::Tag.new(
    name: word,
    slug: word
  )
  tag.save!

end
tags = ActsAsTaggableOn::Tag.all

# Seed Wikis
20.times do |n|

  wiki = Wiki.new(
    title: "Wiki Title #{n}",
    body: Faker::Lorem.paragraph(10),
    private: false,
    user: users.sample
    )
  wiki.tag_list.add tags.sample.name, tags.sample.name
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
  wiki.tag_list.add tags.sample.name, tags.sample.name
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

# Seed Links
20.times do |n|

  link = Link.new(
    title: "Link Title #{n}",
    url: "http://google.com",
    user: users.sample
  )
  link.tag_list.add tags.sample.name
  link.save!

end
links = Link.all

# Seed References
50.times do

  reference = Reference.new(
    wiki: wikis.sample,
    link: links.sample
  )
  reference.save!

end


puts "Finished Seeding."
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."
puts "#{Collaboration.count} collaborations created."
puts "#{ActsAsTaggableOn::Tag.count} tags created."
puts "#{Link.count} links created."
puts "#{Reference.count} references created."