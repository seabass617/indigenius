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

p ''

p 'Creating 10 new Users...'

10.times do
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

p ''

p 'Creating new worskshops...'

craft_url = 'https://www.viator.com/en-CA/Marrakech-tours/Craft-Classes/d5408-g26051-c33939'
craft = Nokogiri::HTML(open(craft_url).read)
p 'Looking for craft worskshops...'

cooking_url = 'https://www.viator.com/en-CA/Marrakech-tours/Cooking-Classes/d5408-g6-c19'
cooking = Nokogiri::HTML(open(cooking_url).read)
p 'Looking for cooking worskshops...'

painting_url = 'https://www.viator.com/en-CA/India-tours/Painting-Classes/d723-g26051-c32009'
painting = Nokogiri::HTML(open(painting_url).read)
p 'Looking for painting worskshops...'

pottery_url = 'https://www.viator.com/en-CA/India-tours/Pottery-Classes/d723-g26051-c32012'
pottery = Nokogiri::HTML(open(pottery_url).read)
p 'Looking for pottery worskshops...'

p ''

[craft, cooking, painting, pottery].each do |workshop|
  i = 0
  until i > 5
    # scraping info
    name = workshop.search("#productName#{i} .text-dark.highlight-able.card-link").text.strip
    description = workshop.search("#productName#{i} .text-body.summary-text.mb-0").text.strip
    price = workshop.search("#productName#{i} .h3.line-height-same.mb-0.price-font.text-md-right")[0].text.strip.tr('€.', '')
    img = workshop.search("#productName#{i} .product-image.with-fallback.tb-b-to-g700-linear.scale-container.half-ease-in-out")
    img.attribute('data-src').value

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
  p ''
end

p 'Creating new products...'

p ''

p 'All set! for now'