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

p '------------------------------------------------------------------------------------'

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

p '------------------------------------------------------------------------------------'

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
p '------------------------------------------------------------------------------------'

[craft, cooking, painting, pottery].each do |workshop|
  i = 0
  until i > 5
    # scraping info
    name = workshop.search("#productName#{i} .text-dark.highlight-able.card-link").text.strip
    description = workshop.search("#productName#{i} .text-body.summary-text.mb-0").text.strip
    price = workshop.search("#productName#{i} .h3.line-height-same.mb-0.price-font.text-md-right")[0].text.strip.tr('€.USD$CA', '')
    # img = workshop.search("#productName#{i} .product-image.with-fallback.tb-b-to-g700-linear.scale-container.half-ease-in-out")

    workshop_page = "https://www.viator.com" + workshop.search("#productName#{i} > div > div.col-6.col-md-6.px-0.pl-3.pr-md-1.d-flex.flex-column.justify-content-md-between > div.flex-md-1.d-flex.flex-column > h2 > a").first.attributes["href"].value
    workshop_images = Nokogiri::HTML(open(workshop_page).read).search("body > div.main-content.d-flex.flex-column.viator-brand > div.flex-grow-1.container-fluid > div:nth-child(6) > div.hero-check-availability-wrapper.row.mt-1.mr-lg-0 > div.col-lg-8.col-12.order-2.order-lg-3.full-width-slider > div.mx-lg-0.position-relative > div.hero-photo-thumbnail-nav > div > img")

    p "Creating workshop #{name}"

    # creating workshop
    new_workshop = Item.create!(
      user_id: User.all.sample.id,
      name: name,
      description: description.tr("\n", ''),
      price_cents: price.to_i,
      category: category[category_index],
      capacity: rand(1..10),
      address: Faker::Address.country,
      workshop: true
    )

    random_duration = rand(1..10)

    3.times do
      fake_date = Faker::Date.between(from: Date.today, to: 1.month.from_now)
      WorkshopDate.create!(
        item_id: new_workshop.id,
        start_date: fake_date,
        end_date: fake_date + random_duration
        )
        puts "workshop_date created for #{new_workshop.name} "
    end
    
    img_index = 0
    workshop_images.each do |img|
      if img.attributes['data-src'].present?
        new_workshop.images.attach(io: open("#{img.attributes['data-src'].value}"), filename: "workshop#{new_workshop.id}#{img_index}.jpg")
        puts "image #{img_index + 1} added to #{new_workshop.name}"
        img_index += 1
      end
    end

    p "#{category[category_index]} worskop: #{name} created!"
    i += 1
  end
  category_index += 1
  p '-------------------------------------------------------'
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
p '------------------------------------------------------------------------------------'

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
      price = product.search("div.display-flex-lg.appears-ready > div.pr-xs-0.pl-xs-0.shop-home-wider-items.pb-xs-5 > div.wt-animated > div > ul > li > a > div.v2-listing-card__info > div > span > span.currency-value").text.strip
      imgs = product.search("#listing-right-column > div > div.body-wrap.wt-body-max-width.wt-display-flex-md.wt-flex-direction-column-xs > div.image-col.wt-order-xs-1.wt-mb-lg-6 > div > div > div > div > div.image-carousel-container.wt-position-relative.flex-xs-6.order-xs-2.show-scrollable-thumbnails > ul > li img")
      # address = product.search("#listing-right-column > div > div.body-wrap.wt-body-max-width.wt-display-flex-md.wt-flex-direction-column-xs > div.listing-info.info-col.description-right.wt-order-xs-5 > div > div:nth-child(3) > div.wt-text-caption.wt-text-gray.wt-mt-md-3 > div").text.strip
      
      # creating products

      new_product = Item.create!(
        user_id: User.all.sample.id,
        name: name,
        description: description.tr("\n", ''),
        price_cents: price.tr('€.USD$CABRL', '').to_i,
        category: category[category_index],
        quantity: rand(1..10),
        workshop: false,
        address: Faker::Address.country
      )

      
      index = 0
      imgs.each do |img|
        if img.attributes['src'].present?
          new_product.images.attach(io: open(img.attributes['src'].value), filename: "workshop#{new_product.id}#{index}.jpg")
        else
          new_product.images.attach(io: open(img.attributes['data-src'].value), filename: "workshop#{new_product.id}#{index}.jpg")
        end
        index += 1
      end

      p "#{category[category_index]} product: #{name} created with location #{new_product.address}, price #{new_product.price} and #{imgs.size} photos."

    end
  end
    category_index += 1
  p '------------------------------------------------------------------------------------'
end

"All set!!!"
