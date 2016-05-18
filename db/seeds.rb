User.create!(name:  "Peter Example",
             email: "jupeter5@ca.ibm.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name:  "Nonadmin Example",
             email: "nonadmin@ca.ibm.com",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@ca.ibm.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
							 activated: true,
							 activated_at: Time.zone.now)
end
