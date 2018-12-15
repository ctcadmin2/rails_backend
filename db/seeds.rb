# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)
5.times do
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

10.times do
  v = Vehicle.create(
    vin: Faker::Vehicle.vin,
    registration: Faker::Lorem.characters(7),
    tipe: Faker::Vehicle.car_type,
    active: Faker::Boolean.boolean(true_ratio = 0.7)
  )
  10.times do
    CreditNote.create(
      number: Faker::Number.number(10),
      start: Faker::Address.city,
      stop: Faker::Address.city,
      week: Faker::Number.between(1, 56),
      value: Faker::Commerce.price,
      currency: Faker::Currency.code,
      notes: Faker::Lorem.sentence(3),
      paid: Faker::Boolean.boolean(true_ratio = 0.1),
      vehicle_id: v.id
    )
  end
end
