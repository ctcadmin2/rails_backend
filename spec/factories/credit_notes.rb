# frozen_string_literal: true

FactoryBot.define do
  factory :credit_note do
    number { Faker::Number.number(10) }
    value { Faker::Commerce.price }
    currency { Faker::Currency.code }
    vehicle
    credit_invoice
  end
end
