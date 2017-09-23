class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :cif, :phone, :contact, :email
end
