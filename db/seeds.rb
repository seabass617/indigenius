# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'
require 'faker'

# p 'Destroying all users...'
# User.destroy_all
# p 'Destroying all items...'
# Item.destroy_all
# p 'Destroying all order...'
# Order.destroy_all
# p 'Destroying all reviews...'
# Review.destroy_all

p '--------------------'

p 'Creating 05 new Users...'

5.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = "#{user.first_name}_#{user.last_name}@gmail.com"
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save!
  user.avatar.attach(io: open('https://source.unsplash.com/featured/?indigenous-people'))

  p '#{user.first_name} created with email #{user.email}'
end

p '--------------------'

# p 'Creating new worskshops...'

# p 'MOROCCO'

# new_workshop = Item.create!(
#     user_id: User.all.sample.id,
#     name: 'Pottery, discovery workshop in Marrakech',
#     description: 'For children, adults, families, couples or groups, We accompany you the time of a discovery workshop earth matter to release your senses in an inspiring universe.',
#     price: 3077,
#     category: 'pottery'
#     capacity: rand(10),
#     workshop: true)
# new_workshop.images.attach(io: open('https://media.tacdn.com/media/attractions-splice-spp-674x446/08/88/97/f9.jpg'), 
#                             filename: 'workshop#{:id}_01.jpg')
# new_workshop.images.attach(io: open('https://media.tacdn.com/media/attractions-splice-spp-674x446/08/88/9d/ea.jpg'), 
#                             filename: 'workshop#{:id}_02.jpg')
# new_workshop.images.attach(io: open('https://media.tacdn.com/media/attractions-splice-spp-674x446/08/88/ff/dc.jpg'), 
#                             filename: 'workshop#{:id}_03.jpg')

p '--------------------'

# p 'Creating new products...'

p '--------------------'

p 'All set!'