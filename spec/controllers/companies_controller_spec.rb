require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  context 'GET #index' do
    it 'should get valid list of companies' do
      get :index
      expect(response).to be_success
      expect(response.content_type).to eq('application/vnd.api+json')
      jdata = JSON.parse response.body
      expect(jdata['data'][0]['type']).to eq('companies')
      expect(jdata['data'].length).to eq(Company.all.length)
    end

    context 'pagination' do
      it 'should not return more than 5 elements at once by default' do
        FactoryBot.create_list(:random_company, 10)
        get :index
        jdata = JSON.parse response.body
        expect(jdata['data'].length).to eq(5)
      end
      it 'should return as many elements as requested' do
        FactoryBot.create_list(:random_company, 10)
        get :index, params: {page: {size: '7'}}
        jdata = JSON.parse response.body
        expect(jdata['data'].length).to eq(7)
      end
      it 'should return the requested page' do
        FactoryBot.create_list(:random_company, 7)
        get :index, params: {page: {number: '2'}}
        jdata = JSON.parse response.body
        expect(jdata['data'].length).to eq(4)
        expect(jdata['meta']['current_page']).to eq(2)
      end
      it 'should return meta info' do
        get :index
        jdata = JSON.parse response.body
        expect(jdata['meta'].length).to eq(7)
      end
    end

    context 'sorting' do
      it 'Should get properly sorted list' do
        Company.destroy_all
        FactoryBot.create_list(:random_company, 20)
        company = Company.order('name DESC').first
        get :index, params: { sort: '-name' }
        expect(response.status).to eq(200)
        jdata = JSON.parse response.body
        expect(company.name).to eq(jdata['data'][0]['attributes']['name'])
      end
    end

    context 'filtering' do
      it 'Should get filtered list' do
        FactoryBot.create_list(:random_company, 50)
        company = Company.last
        get :index, params: { filter: company.name }
        assert_response :success
        jdata = JSON.parse response.body
        expect(jdata['data'].length).to eq(1)
      end
    end
  end

  context 'GET #show' do
    it 'should return valid company data' do
      company = FactoryBot.create(:random_company)
      get :show, params: { id: company.id }
      expect(response).to be_success
      jdata = JSON.parse response.body
      expect(company.id.to_s).to eq(jdata['data']['id'])
      expect(company.name).to eq(jdata['data']['attributes']['name'])
    end
    it "Should get JSON:API error block when requesting company data with invalid ID" do
      get :show, params: { id: "z" }
      assert_response 404
      jdata = JSON.parse response.body
      expect(jdata['errors'][0]['detail']).to eq('Wrong ID provided')
      expect(jdata['errors'][0]['source']['pointer']).to eq('/data/attributes/id')
    end
  end

  context 'POST #create' do
    it 'creates a company with valid data' do
      post :create, params: {
        data: {
          type: 'companies',
          attributes: {
            name: 'test',
            cif: '11111',
            country: 'RO'
          }
        }
      }
      expect(response.status).to eq(201)
      expect(response.headers['Location']).to match(/companies/)
      expect(response.body).to be_jsonapi_response_for('companies')
    end
    it 'responds with errors' do
      post :create, params: {
        data: {
          type: 'companies',
          attributes: {}
        }
      }
      expect(response.status).to eq(422)
      expect(response.body).to have_jsonapi_errors_for('/data/attributes/name')
    end
  end

  context 'PUT #update' do
    it 'updates a company with valid data' do
      company = FactoryBot.create(:random_company)
      patch :update, params: {
        id: company.id,
        data: {
          type: 'companies',
          attributes: {
            name: 'test2'
          }
        }
      }
      expect(response.status).to eq(200)
      expect(response.body).to be_jsonapi_response_for('companies')
      jdata = JSON.parse response.body
      expect(jdata['data']['attributes']['name']).to eq('test2')
      expect(jdata['data']['attributes']['cif']).to eq(company.cif)
    end
    it 'responds with errors' do
      company = FactoryBot.create(:random_company)
      patch :update, params: {
          id: company.id,
          data: {
              type: 'companies',
              attributes: {
                  name: nil
              }
          }
      }
      expect(response.status).to eq(422)
      expect(response.body).to have_jsonapi_errors_for('/data/attributes/name')
    end
  end

  context 'DELETE #destroy' do
    it 'should delete company' do
      company = FactoryBot.create(:random_company)
      ccount = Company.count - 1
      delete :destroy, params: { id: company.id }
      expect(response).to have_http_status(204)
      expect(ccount).to eq(Company.count)
    end
  end
end
