require 'faker'
require 'open-uri'

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
  description: 'Я добре знаю місто, тому можу допомогти знайти потрібну людину.',
)

volunteer.avatar.attach(io: URI.open(Faker::Avatar.image(slug: 'sternenko', size: '150x150', format: 'png', set: 'set4', bgset: 'bg1')),
                        filename: 'volunteer.png', content_type: 'image/png')

# Create 20 Volunteers
20.times do
  password = Faker::Internet.password
  avatar = URI.parse(Faker::Avatar.image(slug: Faker::Internet.username, size: "150x150", format: "png", set: "set4", bgset: "bg1")).read

  Volunteer.create!(
    name: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    password: password,
    avatar: ActiveStorage::Blob.create_and_upload!(io: StringIO.new(avatar), filename: Faker::Internet.username + ".png", content_type: "image/png"),
    password_confirmation: password,
    phone: Faker::PhoneNumber.cell_phone,
    description: Faker::Lorem.paragraph)
end

# Create Gathering Categories
GatheringCategory.create!(title: 'Військова допомога', description: 'Військова допомога')
GatheringCategory.create!(title: 'Медична допомога', description: 'Медична допомога')
GatheringCategory.create!(title: 'Допомога тваринам', description: 'Допомога тваринам')

# Create 20 Gatherings
20.times do
  photos = []
  3.times do
    file = StringIO.new(URI.parse(Faker::LoremFlickr.image(size: "600x700", search_terms: ['people'])).read)
    photos << ActiveStorage::Blob.create_and_upload!(io: file, filename: Faker::Internet.username + ".png", content_type: "image/png")
  end
  Gathering.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    sum: Faker::Number.decimal(l_digits: 2),
    start: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30),
    end: Faker::Time.between(from: DateTime.now + 30, to: DateTime.now + 60),
    ended: false,
    verification: false,
    photos: photos,
    link: Faker::Internet.url,
    creator: Volunteer.all.sample,
    gathering_category: GatheringCategory.all.sample)
end


