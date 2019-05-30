# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :authenticate_user
end
