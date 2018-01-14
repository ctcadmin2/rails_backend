require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'should have email' do
      user = User.create(password: 'segasega', first_name: 'sega', last_name: 'sega2', ssn: '1234', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'email should be unique' do
      User.create(email: 'sega@sega.org', password: 'segasega', first_name: 'sega', last_name: 'sega2', ssn: '12345', lang: 'en')
      user = User.create(email: 'sega@sega.org', password: 'segasega2', first_name: 'segass', last_name: 'seg', ssn: '1234', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'email should be valid format' do
      user = User.create(email: 'sega', password: 'segasega', first_name: 'sega', last_name: 'sega2', ssn: '1234', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'should have password' do
      user = User.create(email: 'sega@sega.org', first_name: 'sega', last_name: 'sega2', ssn: '1234', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'should have min 8 characters for password' do
      user = User.create(email: 'sega@sega.org', password: 'sega', first_name: 'sega', last_name: 'sega2', ssn: '1234', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'should have first name' do
      user = User.create(email: 'sega@sega.org', password: 'segasega', last_name: 'sega2', ssn: '1234', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'should have last name' do
      user = User.create(email: 'sega@sega.org', password: 'segasega', first_name: 'sega', ssn: '1234', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'should save ssn' do
      user = User.create(email: 'sega@sega.org', password: 'segasega', first_name: 'sega', last_name: 'sega2', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'ssn should be a number' do
      user = User.create(email: 'sega@sega.org', password: 'segasega', first_name: 'sega', last_name: 'sega2', ssn: '124a', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'ssn should be unique' do
      User.create(email: 'sega@sega.org', password: 'segasega', first_name: 'sega', last_name: 'sega2', ssn: '1234', lang: 'en')
      user = User.create(email: 'se@se.org', password: 'segasega', first_name: 'sega', last_name: 'sega2', ssn: '1234', lang: 'en').valid?
      expect(user).to eq(false)
    end
    it 'should save language selected' do
      user = User.create(email: 'sega@sega.org', password: 'segasega', first_name: 'sega', last_name: 'sega2', ssn: '1234').valid?``
      expect(user).to eq(false)
    end
  end
end
