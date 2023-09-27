class Facility
  attr_reader :name, 
              :address, 
              :phone, 
              :services,
              :registered_vehicles, 
              :collected_fees, 
              :fee_info

  def initialize(facility_info)
    @name = facility_info[:name]
    @address = facility_info[:address]
    @phone = facility_info[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
    @fee_info = {
      antique: { fee: 25, plate_type: :antique }, 
      electric: { fee: 200, plate_type: :ev },
      regular: { fee: 100, plate_type: :regular }
    }
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    vehicle_type = determine_vehicle_type(vehicle)
    vehicle_type_info = fee_info[vehicle_type]

    @collected_fees += vehicle_type_info[:fee]
    vehicle.change_plate_type(vehicle_type_info[:plate_type])
    vehicle.change_registration_date
    @registered_vehicles.push(vehicle)
  end

  def determine_vehicle_type(vehicle)
    return :antique if vehicle.antique?
    return :electric if vehicle.electric_vehicle?
    :regular
  end
end


# ORIGINAL:
# def register_vehicle(vehicle)
#   if vehicle.antique?
#     @collected_fees += 25 
#     vehicle.change_plate_type(:antique)
#   elsif vehicle.electric_vehicle?
#     @collected_fees += 200
#     vehicle.change_plate_type(:ev)
#   else
#     @collected_fees += 100
#     vehicle.change_plate_type(:regular)
#   end
  
#   vehicle.change_registration_date
#   @registered_vehicles.push(vehicle)
# end

# FIRST REFACTOR:
# def register_vehicle(vehicle)
#   fee = nil
#   plate_type = nil

#   if vehicle.antique?
#     fee = 25 
#     plate_type = :antique
#   elsif vehicle.electric_vehicle?
#     fee = 200
#     plate_type = :ev
#   else
#     fee = 100
#     plate_type = :regular
#   end
  
#   @collected_fees += fee
#   vehicle.change_plate_type(plate_type)
#   vehicle.change_registration_date
#   @registered_vehicles.push(vehicle)
# end

