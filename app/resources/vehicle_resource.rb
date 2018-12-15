# definition of vehicle resource
# type is reserved word
class VehicleResource < BaseResource
  attributes :vin, :registration, :tipe, :active

  has_many :credit_notes

  paginator :paged
end
