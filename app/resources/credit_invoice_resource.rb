# frozen_string_literal: true

class CreditInvoiceResource < BaseResource
  attributes :number, :date, :total_value

  # has_many :credit_notes

  paginator :paged

  filter :q, apply: lambda { |records, value, _options|
    q = records.ransack(number_cont: value[0])
    q.result(distinct: true)
  }
end
