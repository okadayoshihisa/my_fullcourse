20.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678'
  )  
end

store = Store.create(
  name: 'hoge',
  address: Faker::Address.full_address,
  latitude: Faker::Address.latitude,
  longitude: Faker::Address.longitude
)

User.all.each do |user|
  8.times do |index|
    user.fullcourse_menus.create(
      name: Faker::Food.dish,
      genre: FullcourseMenu.genres.keys[index],
      store_id: store.id
    )
  end
  user.create_fullcourse(
    fullcourse_image: File.open("./app/assets/images/fullcourse.jpeg")
  )
end