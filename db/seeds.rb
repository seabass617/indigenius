require 'open-uri'
require 'nokogiri'
require 'faker'

p 'Destroying all order...'
Order.destroy_all
p 'Destroying all reviews...'
Review.destroy_all
p 'Destroying all items...'
Item.destroy_all
p 'Destroying all users...'
User.destroy_all

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
  user.avatar.attach(io: open('https://source.unsplash.com/featured/?indigenous-people'),
                     filename: "#{user.first_name}_avatar.jpg")

  p "#{user.first_name} created with email #{user.email}"
end

p '--------------------'

p 'Creating new worskshops...'

p 'Craft worskshops:'

url = 'https://www.viator.com/en-CA/Marrakech-tours/Craft-Classes/d5408-g26051-c33939'
html = Nokogiri::HTML(open(url).read)

i = 0

until i > 10
  # scraping info
  name = html.search("#productName#{i} .text-dark.highlight-able.card-link").text.strip
  description = html.search("#productName#{i} .text-body.summary-text.mb-0").text.strip
  price = html.search("#productName#{i} .h3.line-height-same.mb-0.price-font.text-md-right")[0].text.strip.tr('€.', '')
  img = html.search("#productName#{i} .product-image.with-fallback.tb-b-to-g700-linear.scale-container.half-ease-in-out")
  img.attribute("data-src").value

  # creating workshop
  new_workshop = Item.create!(
    user_id: User.all.sample.id,
    name: name,
    description: description.tr("\n", ''),
    price: price.tr('€.', ''),
    category: 'craft',
    capacity: rand(10),
    workshop: true
    )
  new_workshop.images.attach(io: open("#{img.attribute("data-src").value}"), filename: "workshop#{:id}.jpg")

  p "#{name} created"

  i += 1
end

p 'Pottery worskshops:'

url = 'https://www.viator.com/en-CA/Marrakech-tours/Pottery-Classes/d5408-g26051-c32012'
html = Nokogiri::HTML(open(url).read)

i = 0

until i > 10 
  # scraping info
  name = html.search("#productName#{i} .text-dark.highlight-able.card-link").text.strip
  description = html.search("#productName#{i} .text-body.summary-text.mb-0").text.strip
  price = html.search("#productName#{i} .h3.line-height-same.mb-0.price-font.text-md-right")[0].text.strip.tr('€.', '')
  img = html.search("#productName#{i} .product-image.with-fallback.tb-b-to-g700-linear.scale-container.half-ease-in-out")
  img.attribute("data-src").value
 
  # creating workshop
  new_workshop = Item.create!(
    user_id: User.all.sample.id,
    name: name,
    description: description.tr("\n", ''),
    price: price.tr('€.', ''),
    category: 'craft',
    capacity: rand(10),
    workshop: true
    )
  new_workshop.images.attach(io: open("#{img.attribute("data-src").value}"), filename: "workshop#{:id}.jpg")

  p "#{name} created"

  i += 1
end

p 'Cooking worskshops:'

url = 'https://www.viator.com/en-CA/Marrakech-tours/Cooking-Classes/d5408-g6-c19'
html = Nokogiri::HTML(open(url).read)

i = 0

until i > 10 
  # scraping info
  name = html.search("#productName#{i} .text-dark.highlight-able.card-link").text.strip
  description = html.search("#productName#{i} .text-body.summary-text.mb-0").text.strip
  price = html.search("#productName#{i} .h3.line-height-same.mb-0.price-font.text-md-right")[0].text.strip.tr('€.', '')
  img = html.search("#productName#{i} .product-image.with-fallback.tb-b-to-g700-linear.scale-container.half-ease-in-out")
  img.attribute("data-src").value
 
  # creating workshop
  new_workshop = Item.create!(
    user_id: User.all.sample.id,
    name: name,
    description: description.tr("\n", ''),
    price: price.tr('€.', ''),
    category: 'craft',
    capacity: rand(10),
    workshop: true
    )
  new_workshop.images.attach(io: open("#{img.attribute("data-src").value}"), filename: "workshop#{:id}.jpg")

  p "#{name} created"

  i += 1
end

# p '--------------------'

# # p 'Creating new products...'

p '--------------------'

p 'All set! for now'