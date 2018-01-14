class ApiHelpersController < ApplicationController
  include JSONAPI::Utils
  before_action :authenticate_user

  def countries
    list = CountriesService.new
    jsonapi_render json: list.make_list, options: { resource: CountryResource, model: Country }
  end

  def openapi
    response = OpenapiService.new(params)
    if response.status
      jsonapi_render json: response.hash, options: { resource: CompanyResource, model: Company }
    else
      jsonapi_render_errors json: response.hash
    end
  end

  def vies
    response = ViesService.new(params)
    if response.status
      jsonapi_render json: response.hash, options: { resource: CompanyResource, model: Company }
    else
      jsonapi_render_errors json: response.hash
    end
  end
end
