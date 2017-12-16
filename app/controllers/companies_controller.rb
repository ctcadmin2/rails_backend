class CompaniesController < ApplicationController
  include PaginationHelper

  before_action :set_company, only: %i(show update destroy)

  # GET /companies
  def index
    q = Company.ransack(name_or_cif_cont: params[:filter] ||= '')
    sort_params = !params[:sort].nil? ? sorted_list(params[:sort]) : 'name'
    @companies = q.result(distinct: true)
                  .order(sort_params)
                  .page(page_number(params[:page]))
                  .per(page_size(params[:page]))

    render jsonapi: @companies, meta: meta_pagination(@companies)
  end

  # GET /companies/1
  def show
    render json: @company
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    if @company.save
      render json: @company, status: :created, location: @company
    else
      render_error(@company, :unprocessable_entity)
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      render json: @company
    else
      render_error(@company, :unprocessable_entity)
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
    head 204
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    begin
      @company = Company.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      company = Company.new
      company.errors.add(:id, 'Wrong ID provided')
      render_error(company, 404) && return
    end
  end

  # Only allow a trusted parameter "white list" through.
  def company_params
    ActiveModelSerializers::Deserialization
        .jsonapi_parse(params,
                       only: %i(name registration cif address
                                acc_eur acc_ron bank capital phone
                                email contact country vies status))
  end
end
