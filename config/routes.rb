Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  jsonapi_resources :companies
  jsonapi_resources :users

  get 'api_helpers/countries', to: 'api_helpers#countries'
  get 'api_helpers/openapi', to: 'api_helpers#openapi'
  get 'api_helpers/vies', to: 'api_helpers#vies'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
