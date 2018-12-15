# controller for different api helper methods
# countries return a list of countries for creating a
# select input
# openapi search for valid company info on openapi.ro
# vies checks eu vat status and company info
class ApiHelpersController < ApplicationController
  before_action :authenticate_user

  def countries
    list = CountriesService.new
    render json: list.make_list
  end

  def openapi
    response = OpenapiService.new(params)
    render json: response.hash
  end

  def vies
    response = ViesService.new(params)
    render json: response.hash
  end
end
