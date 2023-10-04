class FacilityFactory 

  def initialize
    @dds_service = DmvDataService.new
  end

  def create_facility(office_locations)
    office_locations.map do |office|
      Facility.new(
        name: office[:dmv_office],
        address: "#{office[:address_li]} #{office[:address__1]} #{office[:city]} #{office[:state]} #{office[:zip]}",
        phone: office[:phone]
      )
    end
  end
end