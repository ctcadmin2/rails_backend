# frozen_string_literal: true

class Company < ApplicationRecord
  validates :name, :cif, :country, presence: true
  validates :cif, uniqueness: true

  has_many :credit_invoices
end
