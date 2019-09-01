# frozen_string_literal: true

class CreditNote < ApplicationRecord
  validates :number, uniqueness: true
  validates :number, :value, :currency, presence: true

  belongs_to :vehicle
  belongs_to :credit_invoice
end
