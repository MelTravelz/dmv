class VehicleFactory

  def initialize
    @dds_service = DmvDataService.new
  end

  def create_vehicles(registrations)
    registrations.map do |registration|
      Vehicle.new(
        vin: registration[:vin_i_10],
        year: registration[:model_year],
        make: registration[:make],
        model: registration[:model],
        engine: :ev,
        registration_date: nil,
        plate_type: nil
      )
    end
  end
end