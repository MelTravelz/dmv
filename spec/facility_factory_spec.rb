require 'spec_helper'

RSpec.describe FacilityFactory do
  let(:facility_factory) { FacilityFactory.new }
  let(:dds_service) { DmvDataService.new })

  describe '#initialize' do
    it 'can initialize' do
      expect(facility_factory).to be_an_instance_of(FacilityFactory)
      expect(dds_service).to be_an_instance_of(DmvDataService)
    end
  end
end