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

category = ['craft', 'cooking', 'painting', 'pottery']
category_index = 0
p ''

[craft, cooking, painting, pottery].each do |workshop|
  i = 0
  until i > 5
    # scraping info
    name = workshop.search("#productName#{i} .text-dark.highlight-able.card-link").text.strip
    description = workshop.search("#productName#{i} .text-body.summary-text.mb-0").text.strip
    price = workshop.search("#productName#{i} .h3.line-height-same.mb-0.price-font.text-md-right")[0].text.strip.tr('€.US$CA', '')
    img = workshop.search("#productName#{i} .product-image.with-fallback.tb-b-to-g700-linear.scale-container.half-ease-in-out")
    
    # creating workshop
    new_workshop = Item.create!(
      user_id: User.all.sample.id,
      name: name,
      description: description.tr("\n", ''),
      price: price,
      category: category[category_index],
      capacity: rand(1..10),
      workshop: true
    )
    new_workshop.images.attach(io: open("#{img.attribute("data-src").value}"), filename: "workshop#{:id}.jpg")
    p "#{category[category_index]} worskop: #{name} created"
    i += 1
  end
  category_index += 1
  p ''
end

p 'Creating new products...'

bags_url = 'https://www.etsy.com/shop/OriginGalleria?section_id=28357039'
bags = Nokogiri::HTML(open(bags_url).read)
p 'Looking for bags...'

clothes_url = 'https://www.etsy.com/shop/OriginGalleria?section_id=28862811'
clothes = Nokogiri::HTML(open(clothes_url).read)
p 'Looking for clothes...'

wall_hangings_url = 'https://www.etsy.com/shop/OriginGalleria?section_id=28341232'
wall_hangings = Nokogiri::HTML(open(wall_hangings_url).read)
p 'Looking for wall hangings...'

objects_url = 'https://www.etsy.com/shop/OriginGalleria?section_id=28352541'
objects = Nokogiri::HTML(open(objects_url).read)
p 'Looking for objects...'

category = ['bag', 'clothe', 'wall hanging', 'object']
category_index = 0
p ''

[bags, clothes, wall_hangings, objects].each do |product_type|
  i = 0
  product_type.search('.listing-link').each do |products|
    if i < 3
      i += 1
    else
      # scraping info
      product = Nokogiri::HTML(open(products.attribute('href').value).read)
      name = product.search('.wt-text-body-03.wt-line-height-tight.wt-break-word.wt-mb-xs-1').text.strip
      description = product.search('.wt-text-body-01.wt-break-word').text.strip
      price = product.search('.wt-text-title-03.wt-mr-xs-2').text.strip
      img = product.search('.wt-max-width-full.wt-horizontal-center.wt-vertical-center.carousel-image.wt-rounded')

      # creating products
      new_product = Item.create!(
        user_id: User.all.sample.id,
        name: name,
        description: description.tr("\n", ''),
        price: price.tr(' €.$BRL', ''),
        category: category[category_index],
        quantity: rand(1..10),
        workshop: false
      )
      new_product.images.attach(io: open("#{img.attribute('src').value}"), filename: "workshop#{:id}.jpg")
      p "#{category[category_index]} product: #{name} created"

    end
  end
    category_index += 1
  p ''
end

"All set!!!"
