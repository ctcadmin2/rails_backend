class Pref < ApplicationRecord
  include Storext.model
  # "settings" matches what we named the database column

  store_attributes :main do

    activities Array, default: ['to be removed']
    currencies Array, default: ['to be removed']
    paid_by Array, default: ['to be removed']
    vat_rate Array, default: ['to be removed']
    veh_cat Array, default: ['to be removed']
    diurna_baza Integer, default: 0
    salar_baza Integer, default: 0
  end

  store_attributes :company do
    name String, default: 'to be removed'
    registration String, default: 'to be removed'
    vat String, default: 'to be removed'
    address String, default: 'to be removed'
    acc_ron String, default: 'to be removed'
    acc_eur String, default: 'to be removed'
    bank String, default: 'to be removed'
    capital Integer, default: 0
    phone String, default: 'to be removed'
    email String, default: 'to be removed'
    contact String, default: 'to be removed'
  end
end
