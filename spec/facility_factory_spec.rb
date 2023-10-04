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

    it 'can format NY facilities' do
      ny_office_input = [{
        :office_name=>"EVANS",
        :office_type=>"COUNTY OFFICE",
        :public_phone_number=>"7168587450",
        :street_address_line_1=>"6853 ERIE RD",
        :city=>"DERBY",
        :state=>"NY",
        :zip_code=>"14006"
      }]
      ny_facilities = facility_factory.create_facility(ny_office_input)

      expect(ny_facilities[0].name).to eq("Evans County Office")
      expect(ny_facilities[0].address).to eq("6853 Erie Rd Derby NY 14006")
      expect(ny_facilities[0].phone).to eq("(716) 858-7450")
    end

    it 'can create an array of facilities from a different state: MO' do
      mo_dmv_office_locations = dds_service.mo_dmv_office_locations
      mo_facilities = facility_factory.create_facility(mo_dmv_office_locations)

      expect(mo_facilities).to be_an(Array)
      expect(mo_facilities.size).to eq(179)
      expect(mo_facilities[0]).to be_a(Facility)
    end

    it 'can format MO facilities' do
      ny_office_input = [{
        :name=>"OAKVILLE",
        :address1=>"3164 TELEGRAPH ROAD",
        :city=>"ST LOUIS",
        :state=>"MO",
        :zipcode=>"63125",
        :phone=>"(314) 887-1050"
      }]
      ny_facilities = facility_factory.create_facility(ny_office_input)

      expect(ny_facilities[0].name).to eq("Oakville Office")
      expect(ny_facilities[0].address).to eq("3164 Telegraph Road St Louis MO 63125")
      expect(ny_facilities[0].phone).to eq("(314) 887-1050")
    end
  end
end