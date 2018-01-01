class ViesService
  attr_reader :hash, :status

  def initialize(param)
    @cif = param[:cif]
    @country = param[:country]
    make_hash
  end

  private

  def make_hash
    response = get_response(@cif, @country)
    if (200..207).cover?(response.code)
      if JSON.parse(response)['valid']
        @status = true
        @hash = build_company(response)
      else
        @hash = build_error(response)
      end
    else
      @hash = build_error(response)
    end
  end

  def get_response(cif, country)
    begin
      RestClient.get "http://apilayer.net/api/validate?access_key=#{ENV['VATLAYER_KEY']}&vat_number=#{country}#{cif}&format=1"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def build_company(data)
    parsed_response = JSON.parse(data)
    address = parsed_response['company_address'].split("\n").join(', ').titleize
    {
      data: {
        id: @cif,
        name: parsed_response['company_name'].titleize,
        cif: @cif,
        country: @country,
        address: address,
        vies: true,
        status: true
      }
    }
  end

  def build_error(data)
    parsed_data = JSON.parse(data)
    case
      when !parsed_data['success'].nil?
        er = parsed_data['error']
        [{ id: er['type'], title: er['info'], code: er['code'] }]
      when !parsed_data['valid'].nil?
        [{ id: 'cif_not_found', title: 'The supplied cif could not be found', code: 404 }]
      else
        [{ id: parsed_data['id'], title: parsed_data['description'], code: parsed_data['status'] }]
    end
  end
end