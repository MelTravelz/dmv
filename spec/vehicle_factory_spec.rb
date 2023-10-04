require 'spec_helper'

RSpec.describe VehicleFactory do
  let(:vehicle_factory) { VehicleFactory.new }
  
  describe '#initialize' do
    it 'can initialize' do
      expect(vehicle_factory).to be_an_instance_of(VehicleFactory)
    end
  end
end