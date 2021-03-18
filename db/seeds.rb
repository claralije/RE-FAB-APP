require 'faker'
# Examples:
Favorite.destroy_all
Review.destroy_all
Chatroom.destroy_all
Deal.destroy_all
Product.destroy_all
User.destroy_all

cities = ["Seven Sisters, London", "Hackney, London", "Peckham, London", "Shepherd\'s Bush, London", "South Kensington, London", "Brick Lane, London", "Camden, London", "Holborn, London", "Soho, London", "Brixton, London"]
schools = ['Central Saint Martins', 'London College Of Fashion', 'Westminster', 'Goldsmiths', 'Istituto Marangoni', 'Kingston', 'Royal College of Art']
status = ['pending', 'in_process', 'closed']
colors = ["White", "Yellow", "Blue", "Red", "Green", "Black", "Brown", "Azure", "Ivory", "Teal", "Silver", "Purple", "Navy blue", "Pea green", "Gray", "Orange", "Maroon", "Charcoal", "Aquamarine", "Coral", "Fuchsia", "Wheat", "Lime", "Crimson", "Khaki", "Hot pink", "Magenta", "Olden", "Plum", "Olive", "Cyan"]


30.times do
user = User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  location: cities.sample,
  password: 'password',
  bio: Faker::Quotes::Shakespeare.hamlet_quote,
  school: schools.sample,
  average_rating: rand(1...5),
  )
puts "#{user.name} created"
end


fabric = ['silk', 'cotton', 'polyester', 'linen', 'leather', 'tencel', 'wool', 'latex', 'pineapple leather', 'faux fur']
condition = ['new', 'used']
product_status = ['available', 'sold']

products = [
  {
    title: "QiBao Silk",
    description: 'Genuine silk textile, ideal for traditional Chinese garments and especially Chinese New Year.',
    fabric: 'silk',
    color: 'Red',
    weight: rand(1...10),
    condition: condition.sample,
    status: 'available',
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: rand(20...50)
  },
  {
    title: "Calico",
    description: 'I am pivoting away from fashion and need to get rid of all this calico that I bought to toile with. Happy to negotiate on price as I want them all gone.',
    fabric: 'cotton',
    color: 'Ivory',
    weight: rand(1...10),
    condition: condition.sample,
    status: product_status.sample,
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: 3
  },
  {
    title: "Hessian",
    description: 'Bought this for a potato sack photoshoot, have no use for it anymore however',
    fabric: 'cotton',
    color: 'Brown',
    weight: rand(1...10),
    condition: condition.sample,
    status: product_status.sample,
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: rand(1...10)
  },
  {
    title: "Baby blue tulle",
    description: 'Planned to make tutus with it but my schedule is just way too busy. Bought at Brick Lane fabric stores.',
    fabric: 'polyester',
    color: 'Blue',
    weight: rand(1...10),
    condition: condition.sample,
    status: product_status.sample,
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: rand(1...5)
  },
  {
    title: "Gold Sassy Leather",
    description: 'Impulse purchase at a famous Drag Queen\'s yard sale',
    fabric: 'leather',
    color: 'Yellow',
    weight: rand(1...10),
    condition: condition.sample,
    status: product_status.sample,
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: rand(5...40)
  },
  {
    title: "Graduate CSM BA Knit SAMPLE",
    description: 'One of the bigger samples I produced during my knit course at CSM, it\'s just collecting dust and I reckon someone could make something good out of it',
    fabric: 'wool',
    color: 'Coral',
    weight: rand(1...10),
    condition: 'new',
    status: product_status.sample,
    quantity: 1,
    location: cities.sample,
    user: User.all.sample,
    price: rand(10...40)
  },
  {
    title: "beige faux fur",
    description: 'Bought this for a perfume shoot I did for a client, but I have no use for it anymore',
    fabric: 'faux fur',
    color: 'Ivory',
    weight: rand(1...10),
    condition: condition.sample,
    status: product_status.sample,
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: rand(5...20)
  },
  {
    title: "Deep blue sequined fabric",
    description: 'Made some sassy trousers out of this to wear to a festival, bought more thinking i\'d make a whole outfit but I got lazy',
    fabric: 'polyester',
    color: 'Blue',
    weight: rand(1...10),
    condition: condition.sample,
    status: product_status.sample,
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: rand(5...10)
  },
  {
    title: "White cotton good for shirts",
    description: 'Made a shirt out of it, easy to work with, still got 2m to spare, need to get rid as I am moving out soon',
    fabric: 'cotton',
    color: 'White',
    weight: rand(1...10),
    condition: condition.sample,
    status: product_status.sample,
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: rand(5...400)
  },
  {
    title: "Theatrical Organza",
    description: 'used by the costume making department at the Royal Theatre',
    fabric: 'polyester',
    color: 'Blue',
    weight: rand(1...10),
    condition: condition.sample,
    status: product_status.sample,
    quantity: rand(1...30),
    location: cities.sample,
    user: User.all.sample,
    price: rand(5...30)
  }
]

count = 1
products.each do |x|
  product = Product.create!(x)
  puts "Product #{product.title} created"
  path = Rails.root.join("db/photos/#{count}.jpg")
  file = File.open(path)
  product.photos.attach(io: file, filename: "#{product.title}_pic_1.jpg", content_type: ('image/jpg'))
  puts "Product #{product.title} 1 image attached"
  path = Rails.root.join("db/photos/#{count + 1}.jpg")
  file = File.open(path)
  product.photos.attach(io: file, filename: "#{product.title}_pic_1.jpg", content_type: ('image/jpg'))
  puts "Product #{product.title} 2 images attached"
  count += 2
end
# 30.times do
# product = Product.create!(
#   title: Faker::Game.title,
#   description: 'The best fabric of all time',
#   fabric: fabric.sample,
#   color: colors.sample,
#   weight: rand(1...10),
#   condition: condition.sample,
#   status: product_status.sample,
#   quantity: rand(1...30),
#   location: cities.sample,
#   user: User.all.sample,
#   price: rand(5...400)
#   )
# end

# 30.times do
# deal = Deal.create!(
#   status: status.sample,
#   user: User.all.sample,
#   product: Product.all.sample,
# )
#   review = [true, false].sample
#   if review
#     review = Review.create(
#     title: Faker::Game.title,
#     content: Faker::Restaurant.review,
#     rating: rand(1...5),
#     deal: deal,
#     user: deal.user
#     )
#   end
# end

# 30.times do
# fav = Favorite.create!(
#   user: User.all.sample,
#   product: Product.all.sample
#   )
# end


