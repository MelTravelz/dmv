require 'spec_helper'

RSpec.describe FacilityFactory do
  let(:facility_factory) { FacilityFactory.new }
  let(:dds_service) { DmvDataService.new }

  describe '#initialize' do
    it 'can initialize' do
      expect(facility_factory).to be_an_instance_of(FacilityFactory)
      expect(dds_service).to be_an_instance_of(DmvDataService)
    end
  end

  describe '#create_facility' do
    it 'can create an array of facilities' do
      co_dmv_office_locations = dds_service.co_dmv_office_locations
      co_facilities = facility_factory.create_facility(co_dmv_office_locations)

      expect(co_facilities).to be_an(Array)
      expect(co_facilities.size).to eq(5)
      expect(co_facilities[0]).to be_a(Facility)
    end

    it 'can create an array of facilities from a different state: NY' do
      ny_dmv_office_locations = dds_service.ny_dmv_office_locations
      ny_facilities = facility_factory.create_facility(ny_dmv_office_locations)

      expect(ny_facilities).to be_an(Array)
      expect(ny_facilities.size).to eq(171)
      expect(ny_facilities[0]).to be_a(Facility)
    end
  end
end