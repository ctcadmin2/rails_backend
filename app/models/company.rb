class Company < ApplicationRecord
  validates :name, :cif, :country, presence: true
  validates :cif, uniqueness: true
end
