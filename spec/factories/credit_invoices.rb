# frozen_string_literal: true

FactoryBot.define do
  factory :credit_invoice do
    number { Faker::Number.number(10) }
    date { Faker::Date.backward(14) }
    total_value { Faker::Commerce.price }
    association :company, factory: :random_company

    factory :credit_invoice_with_assoc do
      transient do
        credit_notes_count { 10 }
      end
      after(:create) do |credit_invoice, evaluator|
        create_list(:credit_note, evaluator.credit_notes_count, credit_invoice: credit_invoice)
      end
    end
  end
end
