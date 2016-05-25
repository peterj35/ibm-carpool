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
                 image_name: "8200.jpg",
                 description: "The IBM Toronto Software Lab is the largest software development laboratory in 
                  Canada, and IBM's third largest software lab. Established in 1967 with 55 employees, the 
                  Toronto Lab (located in Markham) now has 2,500 employees developing some of IBM's middleware 
                  software. Some of these include DB2, WebSphere Commerce, WebSphere Customer Center, Tivoli 
                  Provisioning Manager, System i languages, and Rational Application Developer. The software 
                  lab was relocated to Markham from a building in Toronto on September 11, 2001.",
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
  specific_location = Faker::Name.name
	postal_code = "L6G3C5"
	location_id = 1
	brief = Faker::Lorem.sentence(30)
	users.each { |user| user.create_offer!(title: title, specific_location: specific_location, 
                                        postal_code: postal_code, location_id: location_id, brief: brief) }
end
