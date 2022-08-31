20.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678'
  )  
end

store = 8.times.map do
  Store.create(
    name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
end

User.all.each do |user|
  8.times do |index|
    user.fullcourse_menus.create(
      name: Faker::Food.dish,
      genre: FullcourseMenu.genres.keys[index],
      store_id: store[index].id
    )
  end
  user.create_fullcourse(
    fullcourse_image: File.open("./app/assets/images/fullcourse.jpeg")
  )
end

User.create(
  name: 'admin',
  email: 'admin@admin.com',
  password: 'admin',
  password_confirmation: 'admin',
  role: 1
)  
