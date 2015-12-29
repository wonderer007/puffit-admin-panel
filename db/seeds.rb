
followers = ["923124553236", "923134489571", "923151010111"]

Array(1..100).each do |response|
  Response.create(
                  message: Faker::Hipster.sentence(3, false, 4), 
                  phone_number: followers[Random.rand(0..2)],
                  user_id: 1)
end