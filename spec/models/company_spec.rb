require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'validation tests' do
    it 'should have name' do
      company = Company.new(cif: '1111', country: 'ss').save
      expect(company).to eq(false)
    end
    it 'should have cif' do
      company = Company.new(name: 'test', country: 'ss').save
      expect(company).to eq(false)
    end
    it 'should have country' do
      company = Company.new(name: 'test', cif: '1111').save
      expect(company).to eq(false)
    end
    it 'cif should be unique' do
      Company.new(name: 'test', cif: '1111', country: 'ss').save
      company = Company.new(name: 'test', cif: '1111', country: 'ss').save
      expect(company).to eq(false)
    end

    it 'should save successfully' do
      company = Company.new(name: 'test', cif: '1111', country: 'ss').save
      expect(company).to eq(true)
    end
  end
end
