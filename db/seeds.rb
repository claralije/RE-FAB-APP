require 'faker'
# Examples:
Review.destroy_all
Product.destroy_all
Favorite.destroy_all
Deal.destroy_all
User.destroy_all

cities = ["los angeles", "berlin", "paris", "pyongyang", "moscow", "canggu", "francheville", "barcelona", "singapore", "jakarta", "london", "miami", "las vegas", "ibiza"]
schools = ['Central Saint Martins', 'London College Of Fashion', 'Westminster', 'Goldsmiths', 'Istituto Marangoni', 'Kingston', 'Royal College of Art']
status = ['in_process', 'closed']

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
end


fabric = ['silk', 'cotton', 'polyester', 'linen', 'leather', 'tencel', 'wool', 'latex', 'pineapple leather', 'faux fur']
condition = ['new', 'used']
product_status = ['available', 'sold']

30.times do
product = Product.create!(
  title: Faker::Game.title,
  description: 'The best fabric of all time',
  fabric: fabric.sample,
  color: Faker::Color.color_name,
  weight: rand(1...10),
  condition: condition.sample,
  status: product_status.sample,
  quantity: rand(1...30),
  location: cities.sample,
  user: User.all.sample,
  price: rand(5...400)
  )
end

30.times do
deal = Deal.create!(
  status: status.sample,
  user: User.all.sample,
  product: Product.all.sample,
)
  review = [true, false].sample
  if review
    review = Review.create!(
    title: Faker::Game.title,
    content: Faker::Restaurant.review,
    rating: rand(1...5),
    deal: deal,
    user: deal.user
    )
  end
end

30.times do
fav = Favorite.create!(
  user: User.all.sample,
  product: Product.all.sample
  )
end


