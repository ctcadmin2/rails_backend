# frozen_string_literal: true

FactoryBot.define do
  factory :credit_invoice do
    number { Faker::Number.number(10) }
    date { Faker::Date.backward(14) }
    total_value { Faker::Commerce.price }
  end
end
