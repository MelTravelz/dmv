class Facility
  attr_reader :name, 
              :address, 
              :phone, 
              :services,
              :registered_vehicles, 
              :collected_fees

  def initialize(facility_info)
    @name = facility_info[:name]
    @address = facility_info[:address]
    @phone = facility_info[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if vehicle.antique?
      @collected_fees += 25 
      vehicle.change_plate_type(:antique)
    elsif vehicle.electric_vehicle?
      @collected_fees += 200
      vehicle.change_plate_type(:ev)
    else
      @collected_fees += 100
      vehicle.change_plate_type(:regular)
    end
    
    @registered_vehicles.push(vehicle)
  end
end
