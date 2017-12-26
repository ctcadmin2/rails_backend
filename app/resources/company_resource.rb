class CompanyResource < BaseResource
  attributes :name, :registration, :cif, :country, :email, :phone, :contact
  filter :name
end
