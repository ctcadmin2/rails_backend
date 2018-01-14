require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:headers) { { CONTENT_TYPE: 'application/vnd.api+json' } }

  context 'POST #create' do
    it 'should create valid user' do
      params = {
        data: {
          type: 'users',
          attributes: {
            email: 'sega@sega.org',
            password: 'segasega',
            password_confirmation: 'segasega',
            first_name: 'sega',
            last_name: 'sega2',
            ssn: '1234',
            lang: 'en'
          }
        }
      }.to_json
      post users_path, params: params, headers: headers
      expect(response.status).to eq(201)
      expect(response.headers['Location']).to match(/users/)
      expect(response.body).to be_json_api_response_for('users')
    end

    it 'should reject active and admin attributes' do
      params = {
        data: {
          type: 'users',
          attributes: {
            email: 'sega@sega.org',
            password: 'segasega',
            password_confirmation: 'segasega',
            first_name: 'sega',
            last_name: 'sega2',
            ssn: '1234',
            lang: 'en',
            active: true,
            admin: true
          }
        }
      }.to_json
      post users_path, params: params, headers: headers
      expect(response.status).to eq(400)
      jdata = JSON.parse(response.body)
      expect(jdata['errors'][0]['detail']).to eq('active is not allowed.')
      expect(jdata['errors'][1]['detail']).to eq('admin is not allowed.')
    end
  end
end
