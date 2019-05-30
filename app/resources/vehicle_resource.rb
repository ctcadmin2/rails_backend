# frozen_string_literal: true

# definition of vehicle resource
# type is reserved word
class VehicleResource < BaseResource
  attributes :vin, :registration, :category, :sold

  has_many :credit_notes

  paginator :paged
end
