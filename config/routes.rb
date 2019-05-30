# frozen_string_literal: true

Rails.application.routes.draw do
  jsonapi_resources :companies
  jsonapi_resources :users
  jsonapi_resources :vehicles
  jsonapi_resources :credit_notes

  post 'user_token' => 'user_token#create'
  get 'api_helpers/countries', to: 'api_helpers#countries'
  get 'api_helpers/openapi', to: 'api_helpers#openapi'
  get 'api_helpers/vies', to: 'api_helpers#vies'
  get 'prefs/company', to: 'prefs#company'
  post 'prefs/company', to: 'prefs#update'
  get 'prefs/main', to: 'prefs#main'
  post 'prefs/main', to: 'prefs#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
