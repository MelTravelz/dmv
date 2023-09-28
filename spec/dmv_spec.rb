require 'spec_helper'

RSpec.describe Dmv do
    let(:dmv) { Dmv.new }
    let(:facility_1) { Facility.new({ name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600' }) }
    let(:facility_2) { Facility.new({ name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600' }) }
    let(:facility_3) { Facility.new({ name: 'DMV 44th Ave Branch', address: '3698 W. 44th Avenue Denver CO 80211', phone: '(720) 865-4600' }) }
    let(:willy_wonka) { Registrant.new(name: "Willy Wonka", age: 40) }
    let(:charlie) { Registrant.new(name: "Charlie Bucket", age: 14) }
    let(:grandpa) { Registrant.new(name: "Grandpa Joe", age: 75) }

  describe '#initialize' do
    it 'can initialize' do
      expect(dmv).to be_an_instance_of(Dmv)
      expect(dmv.facilities).to eq([])
    end
  end

  describe '#add facilities' do
    it 'can add available facilities' do
      expect(dmv.facilities).to eq([])
      dmv.add_facility(facility_1)
      expect(dmv.facilities).to eq([facility_1])
      dmv.add_facility(facility_2)
      expect(dmv.facilities).to eq([facility_1, facility_2])
    end
  end

  describe '#facilities_offering_service' do
    it 'can return list of facilities offering a specified Service' do
      facility_1.add_service('New Drivers License')
      facility_1.add_service('Renew Drivers License')
      
      facility_2.add_service('New Drivers License')
      facility_2.add_service('Road Test')
      facility_2.add_service('Written Test')
      
      facility_3.add_service('New Drivers License')
      facility_3.add_service('Road Test')

      dmv.add_facility(facility_1)
      dmv.add_facility(facility_2)
      dmv.add_facility(facility_3)

      expect(dmv.facilities_offering_service('Road Test')).to eq([facility_2, facility_3])
      expect(dmv.facilities_offering_service('Written Test')).to eq([facility_2])
      expect(dmv.facilities_offering_service('New Drivers License')).to eq([facility_1, facility_2, facility_3])
      expect(dmv.facilities_offering_service('Renew Drivers License')).to eq([facility_1])
    end
  end
end
