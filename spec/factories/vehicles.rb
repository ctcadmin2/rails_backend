# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    registration { Faker::Vehicle.license_plate }
    vin { Faker::Vehicle.vin }
  end
end
