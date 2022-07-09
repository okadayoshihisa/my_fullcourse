20.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678',
    fullcourse_image: File.open("./app/assets/images/fullcourse.jpeg")
  )  
end
