# definition of credit note resource
class CreditNoteResource < BaseResource
  attributes :number, :start, :stop, :week, :value, :currency, :paid, :notes

  has_one :vehicle

  paginator :paged

  filter :q, apply: lambda { |records, value, _options|
    q = records.ransack(number_or_start_or_stop_or_notes_cont: value[0])
    q.result.includes(:vehicle)
  }

  def self.sortable_fields(context)
    super + [:"vehicle.id"]
  end
end
