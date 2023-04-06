require 'faker'

Faker::Config.locale = 'uk' # or Faker::Config.locale = :es

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Create one Volunteer
volunteer = Volunteer.create!(
  name: 'Сергій',
  surname: 'Стерненко',
  email: 'sternenko@example.com',
  username: "sternenko",
  password: 'kolan4ick',
  phone: '+380 67 123 45 67',
  description: 'Я добре знаю місто, тому можу допомогти знайти потрібну людину.')

# Create Gathering Categories
GatheringCategory.create!(title: 'Військова допомога', description: 'Військова допомога')
GatheringCategory.create!(title: 'Медична допомога', description: 'Медична допомога')
GatheringCategory.create!(title: 'Допомога тваринам', description: 'Допомога тваринам')

# Create 50 Gatherings
20.times do
  Gathering.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    sum: Faker::Number.decimal(l_digits: 2),
    start: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30),
    end: Faker::Time.between(from: DateTime.now + 30, to: DateTime.now + 60),
    ended: false,
    verification: false,
    link: Faker::Internet.url,
    creator: volunteer,
    gathering_category: GatheringCategory.all.sample)
end
