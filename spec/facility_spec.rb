require 'spec_helper'

RSpec.describe Facility do
    let(:facility_1) { Facility.new({ name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600' }) }
    let(:facility_2) { Facility.new({ name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600' }) }
    let(:cruz) { Vehicle.new({ vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice }) }
    let(:bolt) { Vehicle.new({ vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev }) }
    let(:camaro) { Vehicle.new({ vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice }) }
    let(:willy_wonka) { Registrant.new(name: "Willy Wonka", age: 40) }
    let(:charlie) { Registrant.new(name: "Charlie Bucket", age: 14, permit: true) }
    let(:violet) { Registrant.new(name: "Violet Beauregarde", age: 16, permit: true) }
    let(:veruca) { Registrant.new(name: "Veruca Salt", age: 16) }

  describe '#initialize' do
    let(:expected_fee_info) do
      {
        antique: { fee: 25, plate_type: :antique }, 
        electric: { fee: 200, plate_type: :ev },
        regular: { fee: 100, plate_type: :regular }
      }
    end

    it 'can initialize' do
      expect(facility_1).to be_an_instance_of(Facility)
      expect(facility_1.name).to eq('DMV Tremont Branch')
      expect(facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(facility_1.phone).to eq('(720) 865-4600')
      expect(facility_1.services).to eq([])
      expect(facility_1.registered_vehicles).to eq([])
      expect(facility_1.collected_fees).to eq(0)
      expect(facility_1.fee_info).to eq(expected_fee_info)
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
    let(:original_license_data) do 
      {
      written: false, 
      license: false, 
      renewed: false
      }
    end

    let(:updated_license_data) do 
      {
      written: true, 
      license: false, 
      renewed: false
      }
    end

    let(:received_license_data) do 
      {
      written: true, 
      license: true, 
      renewed: false
      }
    end

    let(:renewed_license_data) do 
      {
      written: true, 
      license: true, 
      renewed: true
      }
    end

    describe '#register_vehicle' do
      before(:each) do
        facility_1.add_service('Vehicle Registration')
      end

      it 'can collected fees based on vehicle type' do
        expect(facility_1.collected_fees).to eq(0)
        facility_1.register_vehicle(cruz)
        expect(facility_1.collected_fees).to eq(100)
      end

      it 'can set a vehicles plate type' do
        expect(cruz.plate_type).to eq(nil)
        facility_1.register_vehicle(cruz)
        expect(cruz.plate_type).to eq(:regular)
      end

      it 'can add vehicle to facilitys registered_vehicles' do
        expect(facility_1.registered_vehicles).to eq([])
        facility_1.register_vehicle(cruz)
        expect(facility_1.registered_vehicles).to eq([cruz])
      end

      it 'can add set a vehicles registration date' do
        expect(cruz.registration_date).to eq(nil)
        facility_1.register_vehicle(cruz)
        expect(cruz.registration_date).to eq(Date.today)
      end
    end

    describe '#determine_vehicle_type' do
      it 'can determine the vehicle type' do
        expect(facility_1.determine_vehicle_type(cruz)).to eq(:regular)
        expect(facility_1.determine_vehicle_type(bolt)).to eq(:electric)
        expect(facility_1.determine_vehicle_type(camaro)).to eq(:antique)
      end
    end

    describe '#administer_written_test' do
      describe 'happy path tests' do
        before(:each) do
          facility_1.add_service('Written Test')
        end

        it 'can administer a written test to a registrant (16+ age & has permit)' do
          expect(violet.license_data).to eq(original_license_data)
          expect(violet.permit?).to eq(true)
          expect(violet.age).to eq(16)

          facility_1.administer_written_test(violet)
          expect(violet.license_data).to eq(updated_license_data)
        end
      end

      describe 'sad path tests' do
        it 'cannot administer a written test to a registrant if the facility does not offer that Service' do
          expect(violet.license_data).to eq(original_license_data)
          expect(violet.permit?).to eq(true)
          expect(violet.age).to eq(16)

          expect(facility_1.administer_written_test(violet)).to eq(false)
          expect(violet.license_data).to eq(original_license_data)
        end

        it 'cannot administer a written test to a registrant age 16+ without a permit' do
          facility_1.add_service('Written Test')

          expect(veruca.license_data).to eq(original_license_data)
          expect(veruca.permit?).to eq(false)
          expect(veruca.age).to eq(16)

          expect(facility_1.administer_written_test(veruca)).to eq(false)
          expect(veruca.license_data).to eq(original_license_data)
        end

        it 'cannot administer a written test to a registrant under the age of 14' do
          facility_1.add_service('Written Test')
          
          expect(charlie.license_data).to eq(original_license_data)
          expect(charlie.permit?).to eq(true)
          expect(charlie.age).to eq(14)

          expect(facility_1.administer_written_test(charlie)).to eq(false)
          expect(charlie.license_data).to eq(original_license_data)
        end
      end
    end

    describe '#administer_road_test' do
      describe 'happy path tests' do
        before(:each) do
          facility_1.add_service('Written Test')
          facility_1.add_service('Road Test')
        end

        it 'can administer a road test if facility offers Service & give license to registrant who passes the written test' do
          expect(violet.license_data).to eq(original_license_data)
          facility_1.administer_written_test(violet)
          expect(violet.license_data).to eq(updated_license_data)

          expect(facility_1.administer_road_test(violet)).to eq(true)
          expect(violet.license_data).to eq(received_license_data)
        end
      end

      describe 'sad path tests' do
        before(:each) do
          facility_1.add_service('Written Test')
        end

        it 'cannot administer a written test to a registrant if the facility does not offer that Service' do
          expect(violet.license_data).to eq(original_license_data)
          facility_1.administer_written_test(violet)
          expect(violet.license_data).to eq(updated_license_data)

          expect(facility_1.administer_road_test(violet)).to eq(false)
          expect(violet.license_data).to eq(updated_license_data)
        end

        it 'cannot adminster a road test to a registrant who only has a permit (did not take written test)' do
          facility_1.add_service('Road Test')

          expect(veruca.license_data).to eq(original_license_data)
          expect(facility_1.administer_road_test(veruca)).to eq(false)
          expect(veruca.license_data).to eq(original_license_data)

          veruca.earn_permit
          expect(facility_1.administer_road_test(veruca)).to eq(false)
          expect(veruca.license_data).to eq(original_license_data)
        end
      end
    end

    describe '#renew_drivers_license' do
      describe 'happy path tests' do
        before(:each) do
          facility_1.add_service('Written Test')
          facility_1.add_service('Road Test')
          facility_1.add_service('Renew License')
        end

        it "can renew a license if facility offers Service & registrant has a current license" do
          expect(violet.license_data).to eq(original_license_data)
          facility_1.administer_written_test(violet)
          facility_1.administer_road_test(violet)
          expect(violet.license_data).to eq(received_license_data)

          expect(facility_1.renew_license(violet)).to eq(true)
          expect(violet.license_data).to eq(renewed_license_data)
        end
      end

      describe 'sad path tests' do
        before(:each) do
          facility_1.add_service('Written Test')
          facility_1.add_service('Road Test')
        end

        it 'cannot renew a license to a registrant if the facility does not offer that Service' do
          expect(violet.license_data).to eq(original_license_data)
          facility_1.administer_written_test(violet)
          facility_1.administer_road_test(violet)
          expect(violet.license_data).to eq(received_license_data)

          expect(facility_1.renew_license(violet)).to eq(false)
          expect(violet.license_data).to eq(received_license_data)
        end

        it 'cannot renew a license if a registrant does not currently have a license' do
          facility_1.add_service('Renew License')

          expect(violet.license_data).to eq(original_license_data)
          expect(facility_1.renew_license(violet)).to eq(false)
          expect(violet.license_data).to eq(original_license_data)

          facility_1.administer_written_test(violet)
          expect(violet.license_data).to eq(updated_license_data)
          expect(facility_1.renew_license(violet)).to eq(false)
          expect(violet.license_data).to eq(updated_license_data)
        end
      end
    end
  end
end
