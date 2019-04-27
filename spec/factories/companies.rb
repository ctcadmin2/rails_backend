FactoryBot.define do
  factory :company do
    name { 'test company' }
    registration { 'j00/1111/1111' }
    cif { '123456789' }
    address { 'some address' }
    phone { '123456789' }
    email { 'office@email.org' }
    contact { 'some name' }
    country { 'RO' }
  end

  factory :random_company, class: Company do
    name { Faker::Company.name }
    registration { Faker::Company.duns_number }
    cif { Faker::Company.swedish_organisation_number }
    address { "#{Faker::Address.street_address}, #{Faker::Address.city}" }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    contact { Faker::Name.name }
    country { Faker::Address.country_code }
  end
end
