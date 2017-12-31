class CompanyResource < BaseResource
  attributes :name, :registration, :cif, :country, :email, :phone, :contact

  filter :q, apply: ->(records, value, _options) {
    q = records.ransack(name_or_cif_cont: value[0])
    q.result(distinct: true)
  }
end
