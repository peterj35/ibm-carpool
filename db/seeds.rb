User.create!(name:  "Peter Ju (Admin)",
             email: "jupeter5@ca.ibm.com",
             admin: true)

User.create!(name:  "Nonadmin Example",
             email: "nonadmin@ca.ibm.com")

Location.create!(name:		"8200 Warden",
                 image_name: "8200.jpg",
                 description: "The IBM Toronto Software Lab is the largest software development laboratory in 
                  Canada, and IBM's third largest software lab. Established in 1967 with 55 employees, the 
                  Toronto Lab (located in Markham) now has 2,500 employees developing some of IBM's middleware 
                  software. Some of these include DB2, WebSphere Commerce, WebSphere Customer Center, Tivoli 
                  Provisioning Manager, System i languages, and Rational Application Developer. The software 
                  lab was relocated to Markham from a building in Toronto on September 11, 2001.",
								 region:	"Toronto")

Location.create!(name:    "3600 Steeles",
                 image_name: "3600.jpg",
                 description: "IBM Canada's head offices are currently located in Markham, Ontario and have 
                 been there since the early 1980s. The current building IBM occupies is located at 3600 Steeles 
                 Avenue East and was completed in 1995. IBM Canada's previous head office was located across 
                 the street at 3500 Steeles Avenue East (now Liberty Centre, Markham). The building rises from 
                 four floors on the west to seven floors at the east side. There is an underground ramp that is 
                 accessible from the left-most lane on east-bound Steeles Avenue that provides access to the 
                 building's parking area at the rear.",
                 region:  "Toronto")
exit

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
