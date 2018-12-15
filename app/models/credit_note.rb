class CreditNote < ApplicationRecord
  validates :number, uniqueness: true
  validates :number, :value, :currency, presence: true

  belongs_to :vehicle
end
