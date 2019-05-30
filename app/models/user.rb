# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, :first_name, :last_name, :ssn, :lang, presence: true
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :email, :ssn, uniqueness: { case_sensitive: false }
  validates :ssn, numericality: { only_integer: true }
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/

  def to_token_payload
    # Returns the payload as a hash
    { sub: id, admin: admin, active: active }
  end
end
