# definition of vehicle resource
# type is reserved word
class VehicleResource < BaseResource
  attributes :vin, :registration, :category, :active

  has_many :credit_notes

  paginator :paged
end
