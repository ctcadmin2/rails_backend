class Vehicle < ApplicationRecord
  before_save :cap

  validates :registration, :vin, presence: true
  validates :vin, uniqueness: true

  has_many :credit_notes

  protected

  def cap
    self.registration = registration.upcase
    self.vin = vin.upcase
  end
end
