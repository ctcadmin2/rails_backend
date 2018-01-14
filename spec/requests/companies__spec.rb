require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let(:json) { { CONTENT_TYPE: 'application/vnd.api+json' } }
  let(:auth_header) {
    user = FactoryBot.create(:user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    header = {AUTHORIZATION: "Bearer #{token}"}
    header
  }
  let(:auth_json) { json.merge(auth_header)}

  context 'not authorized' do
    it 'should return not auth error' do
      FactoryBot.create_list(:random_company, 4)
      get companies_path, params: {}, headers: {}
      expect(response.status).to eq(401)
    end
  end

  context 'authorized' do
    context 'GET #index' do
      it 'should get valid list of companies' do
        FactoryBot.create_list(:random_company, 4)
        get companies_path, params: {}, headers: auth_header
        expect(response.status).to eq(200)
        expect(response.content_type).to eq('application/vnd.api+json')
        jdata = JSON.parse response.body
        expect(jdata['data'][0]['type']).to eq('companies')
        expect(jdata['data'].length).to eq(4)
        expect(response.body).to be_json_api_response_for('companies')
      end

      context 'pagination' do
        it 'should not return more than 5 elements at once by default' do
          FactoryBot.create_list(:random_company, 10)
          get companies_path, params: {}, headers: auth_header
          jdata = JSON.parse response.body
          expect(jdata['data'].length).to eq(5)
        end
        it 'should return as many elements as requested' do
          FactoryBot.create_list(:random_company, 10)
          get companies_path, params: {page: {size: '7'}}, headers: auth_header
          jdata = JSON.parse response.body
          expect(jdata['data'].length).to eq(7)
        end
        it 'should return the requested page' do
          FactoryBot.create_list(:random_company, 7)
          get companies_path, params: { page: { number: '2' } }, headers: auth_header
          jdata = JSON.parse response.body
          expect(jdata['data'].length).to eq(2)
        end
        it 'should return meta info' do
          get companies_path, params: {}, headers: auth_header
          jdata = JSON.parse response.body
          expect(jdata['meta'].length).to eq(2)
        end
      end

      context 'sorting' do
        it 'Should get sorted results' do
          FactoryBot.create_list(:random_company, 20)
          company = Company.order('name DESC').first
          get companies_path, params: { sort: '-name' }, headers: auth_header
          expect(response.status).to eq(200)
          jdata = JSON.parse response.body
          expect(company.name).to eq(jdata['data'][0]['attributes']['name'])
        end
      end

      context 'filtering' do
        it 'Should get filtered list' do
          FactoryBot.create_list(:random_company, 50)
          company = FactoryBot.create(:company)
          params = { filter: {q: company.name }}
          get companies_path, params: params, headers: auth_header
          assert_response :success
          jdata = JSON.parse response.body
          expect(jdata['data'].length).to eq(1)
        end
      end
    end

    context 'GET #show' do
      it 'should return valid company data' do
        company = FactoryBot.create(:random_company)
        get company_path(company.id), headers: auth_header
        expect(response).to be_success
        jdata = JSON.parse response.body
        expect(company.id.to_s).to eq(jdata['data']['id'])
        expect(company.name).to eq(jdata['data']['attributes']['name'])
      end
      it "Should get JSON:API error block when requesting company data with invalid ID" do
        get company_path('z'), headers: auth_header
        expect(response.status).to eq(400)
        jdata = JSON.parse response.body
        expect(jdata['errors'][0]['detail']).to eq('z is not a valid value for id.')
      end
    end

    context 'POST #create' do
      it 'creates a company with valid data' do
        params = {
          data: {
            type: 'companies',
            attributes: {
              name: 'test',
              cif: '11111',
              country: 'RO'
            }
          }
        }.to_json
        post companies_path, params: params, headers: auth_json
        expect(response.status).to eq(201)
        expect(response.headers['Location']).to match(/companies/)
        expect(response.body).to be_json_api_response_for('companies')
      end
      it 'creates a company with invalid data' do
        params = {
          data: {
            type: 'companies',
            attributes: {}
          }
        }.to_json
        post companies_path, params: params, headers: auth_json
        expect(response.status).to eq(422)
        expect(response.body).to have_jsonapi_errors_for('/data/attributes/name')
      end
    end

    context 'PUT #update' do
      it 'updates a company with valid data' do
        company = FactoryBot.create(:random_company)
        params = {
          data: {
            type: 'companies',
            id: company.id,
            attributes: {
              name: 'test2'
            }
          }
        }.to_json
        patch company_path(company), params: params, headers: auth_json
        expect(response.status).to eq(200)
        expect(response.body).to be_json_api_response_for('companies')
        jdata = JSON.parse response.body
        expect(jdata['data']['attributes']['name']).to eq('test2')
        expect(jdata['data']['attributes']['cif']).to eq(company.cif)
      end
      it 'responds with errors' do
        company = FactoryBot.create(:random_company)
        params = {
          data: {
            type: 'companies',
            id: company.id,
            attributes: {
              name: nil
            }
          }
        }.to_json
        patch company_path(company.id), params: params, headers: auth_json
        expect(response.status).to eq(422)
        expect(response.body).to have_jsonapi_errors_for('/data/attributes/name')
      end
    end

    context 'DELETE #destroy' do
      it 'should delete company' do
        company = FactoryBot.create(:random_company)
        ccount = Company.count - 1
        delete company_path(company), headers: auth_header
        expect(response).to have_http_status(204)
        expect(ccount).to eq(Company.count)
      end
    end
  end
end
