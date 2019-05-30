# frozen_string_literal: true

class PrefsController < ApplicationController
  before_action :authenticate_user

  def main
    prefs = PrefService.new
    render json: prefs.main
  end

  def company
    prefs = PrefService.new
    render json: prefs.company
  end

  def update
    prefs = PrefService.new
    prefs.update(prefs_params)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def prefs_params
    params.require(:prefs).permit({ company: %i[vat bank name email phone acc_eur acc_ron address capital contact registration] }, main: [{ paid_by: [] }, { veh_cat: [] }, { vat_rate: [] }, { activities: [] }, { currencies: [] }, :salar_baza, :diurna_baza])
  end
end
