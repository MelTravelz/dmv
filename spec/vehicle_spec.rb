require 'spec_helper'

RSpec.describe Vehicle do
  let(:cruz) { Vehicle.new({ vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice }) }
  let(:bolt) { Vehicle.new({ vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev }) }
  let(:camaro) { Vehicle.new({ vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice }) }

  describe '#initialize' do
    it 'can initialize' do
      expect(cruz).to be_an_instance_of(Vehicle)
      expect(cruz.vin).to eq('123456789abcdefgh')
      expect(cruz.year).to eq(2012)
      expect(cruz.make).to eq('Chevrolet')
      expect(cruz.model).to eq('Cruz')
      expect(cruz.engine).to eq(:ice)
      expect(cruz.registration_date).to eq(nil)
      expect(cruz.plate_type).to eq(nil)
    end
  end

  describe '#antique?' do
    it 'can determine if a vehicle is an antique' do
      expect(cruz.antique?).to eq(false)
      expect(bolt.antique?).to eq(false)
      expect(camaro.antique?).to eq(true)
    end
  end

  describe '#electric_vehicle?' do
    it 'can determine if a vehicle is an ev' do
      expect(cruz.electric_vehicle?).to eq(false)
      expect(bolt.electric_vehicle?).to eq(true)
      expect(camaro.electric_vehicle?).to eq(false)
    end
  end

  describe '#change_plate_type' do
    it 'can change the plate_type of vehicle' do
      expect(cruz.plate_type).to eq(nil)
      cruz.change_plate_type(:regular)
      expect(cruz.plate_type).to eq(:regular)
    end
  end

  describe '#change_registration_date' do
    it 'can change the registration date of vehicle' do
      expect(cruz.registration_date).to eq(nil)
      cruz.change_registration_date
      expect(cruz.registration_date).to eq(Date.today)
    end
  end
end
