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

Location.create!(name:		"8200 Warden",
								 region:	"Toronto")

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

users = User.order(:created_at).take(40)
location = Location.order(:created_at).take(1)
1.times do
  title = Faker::Lorem.sentence(4)
	postal_code = "L6G3C5"
	location_id = 1
	brief = Faker::Lorem.sentence(5)
	users.each { |user| user.create_offer!(title: title, postal_code: postal_code, location_id: location_id, brief: brief) }
end
