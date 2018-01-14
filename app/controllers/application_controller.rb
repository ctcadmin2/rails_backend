class ApplicationController < ActionController::API
  include Knock::Authenticable
  include JSONAPI::ActsAsResourceController
end
