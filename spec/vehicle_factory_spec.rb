require 'spec_helper'

RSpec.describe VehicleFactory do
  let(:factory) { VehicleFactory.new }
  let(:dds_service) { DmvDataService.new }
  
  describe '#initialize' do
    it 'can initialize' do
      expect(factory).to be_an_instance_of(VehicleFactory)
      expect(dds_service).to be_an_instance_of(DmvDataService)
    end
  end
end