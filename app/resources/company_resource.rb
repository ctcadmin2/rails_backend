# frozen_string_literal: true

class CompanyResource < BaseResource
  attributes :name, :registration, :cif, :address,
             :country, :email, :phone, :contact,
             :acc_eur, :acc_ron, :bank, :capital, :vies, :status

  paginator :custom

  filter :q, apply: lambda { |records, value, _options|
    q = records.ransack(name_or_cif_cont: value[0])
    q.result(distinct: true)
  }
end
