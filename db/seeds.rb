
followers = ["923124553236", "923134489571", "923151010111"]
User.create(email:'alihaider907@gmail.com', username:'wonderer007', password:'12345678', password_confirmation: '12345678')
Array(1..100).each do |response|
  Response.create(
                  message: Faker::Hipster.sentence(3, false, 4), 
                  phone_number: followers[Random.rand(0..2)],
                  user_id: 1)
end