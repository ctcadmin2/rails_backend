# frozen_string_literal: true

class CreditInvoice < ApplicationRecord
  has_many :credit_notes
end
