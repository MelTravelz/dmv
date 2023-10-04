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

  describe '#create_vehicles' do
    it 'can create an array of vehicles' do
      wa_ev_registrations = dds_service.wa_ev_registrations
      wa_vehicles = factory.create_vehicles(dds_service.wa_ev_registrations)

      expect(wa_vehicles).to be_an(Array)
      expect(wa_vehicles.size).to eq(1000)
      expect(wa_vehicles[0]).to be_a(Vehicle)
    end
  end
end