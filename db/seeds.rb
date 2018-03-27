# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)
100.times do
  Company.create(
    name: Faker::Company.name,
    registration: Faker::Company.duns_number,
    cif: Faker::Company.swedish_organisation_number,
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    contact: Faker::Name.name,
    country: Faker::Address.country_code
  )
end
