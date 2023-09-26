require 'spec_helper'

RSpec.describe Facility do
    let(:facility_1) { Facility.new({ name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600' }) }
    let(:facility_2) { Facility.new({ name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600' }) }
    let(:cruz) { Vehicle.new({ vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice }) }
    let(:bolt) { Vehicle.new({ vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev }) }
    let(:camaro) { Vehicle.new({ vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice }) }

  describe '#initialize' do
    it 'can initialize' do
      expect(facility_1).to be_an_instance_of(Facility)
      expect(facility_1.name).to eq('DMV Tremont Branch')
      expect(facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(facility_1.phone).to eq('(720) 865-4600')
      expect(facility_1.services).to eq([])
      expect(facility_1.registered_vehicles).to eq([])
      expect(facility_1.collected_fees).to eq(0)
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(facility_1.services).to eq([])
      facility_1.add_service('New Drivers License')
      facility_1.add_service('Renew Drivers License')
      facility_1.add_service('Vehicle Registration')
      expect(facility_1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe 'services' do
    describe '#register_vehicle' do
      it 'can collected fees based on vehicle type' do
        facility_1.add_service('Vehicle Registration')
        expect(facility_1.collected_fees).to eq(0)
        facility_1.register_vehicle(cruz)
        expect(facility_1.collected_fees).to eq(100)
      end

      it 'can set a vehicles plate type' do
        facility_1.add_service('Vehicle Registration')
        expect(cruz.plate_type).to eq(nil)

        facility_1.register_vehicle(cruz)
        expect(cruz.plate_type).to eq(:regular)
      end
    end
  end
end

# facility_1.add_service('Vehicle Registration')

#   expect(cruz.registration_date).to eq(nil)
#   expect(facility_1.registered_vehicles).to eq([])
#   expect(facility_1.collected_fees).to eq(0)

#   facility_1.register_vehicle(cruz)

#   expect(cruz.registration_date).to eq(Date.today)
#   expect(cruz.plate_type).to eq(:regular)
#   expect(facility_1.registered_vehicles).to eq([cruz])
#   expect(facility_1.collected_fees).to eq(100)
