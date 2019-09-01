# frozen_string_literal: true

# definition of credit note resource
class CreditNoteResource < BaseResource
  attributes :number, :start, :end, :value, :currency, :paid, :notes

  has_one :vehicle
  belongs_to :credit_invoice

  paginator :paged

  filter :q, apply: lambda { |records, value, _options|
    q = records.ransack(number_or_start_or_end_or_notes_cont: value[0])
    q.result.includes(:vehicle)
  }

  def self.sortable_fields(context)
    super + [:vehicle_id]
  end
end
