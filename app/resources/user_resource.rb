# definition of user resource
# we do not expose password_digest
# user should not be able to set active or admin on create
# at the moment we can't modify the password TODO
class UserResource < BaseResource
  attributes :email, :first_name, :last_name, :ssn, :lang,
             :password, :password_confirmation, :admin, :active

  def fetchable_fields
    super - %i[password password_confirmation]
  end

  def self.creatable_fields(context)
    super - %i[active admin]
  end

  def self.updatable_fields(context)
    super - %i[password password_confirmation]
  end
end
