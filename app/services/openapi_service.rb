class OpenapiService
  attr_reader :hash, :status

  def initialize(param)
    @cif = param[:cif]
    @headers = {
      x_api_key: ENV['OPENAPI_KEY']
    }
    @status = false
    @hash = {}
    make_hash
  end

  private

  def make_hash
    response = get_response(@cif)
    if (200..207).cover?(response.code)
      @status = true
      @hash = build_company(response)
    else
      @hash = build_error(response)
    end
  end

  def get_response(cif)
    begin
      RestClient.get "https://api.openapi.ro/api/companies/#{cif}", @headers
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def build_company(data)
    parsed_response = JSON.parse(data)
    address = "#{parsed_response['adresa']}, #{parsed_response['cod_postal']}, #{parsed_response['judet']}"
    {
      data: {
        name: parsed_response['denumire'].titleize,
        registration: parsed_response['numar_reg_com'],
        cif: parsed_response['cif'],
        address: address.gsub("\n",'').titleize,
        country: 'RO',
        phone: parsed_response['telefon'],
        status: !parsed_response['radiata']
      }
    }
  end

  def build_error(data)
    parsed_data = JSON.parse(data)['error']
    {
      error:
      {
        id: parsed_data['id'],
        title: parsed_data['description'],
        code: parsed_data['status']
      }
    }
  end
end
