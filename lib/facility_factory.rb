class FacilityFactory 

  def initialize
    @dds_service = DmvDataService.new
  end

  def create_facility(office_locations)
    office_locations.map do |office|
      case office[:state] 

      when "CO"
        Facility.new(
          name: office[:dmv_office],
          address: "#{office[:address_li]} #{office[:address__1]} #{office[:city]} #{office[:state]} #{office[:zip]}",
          phone: office[:phone]
        )

      when "NY"
        # NOTE: Could refactor into helper methods:
        formatted_phone = ""
        if office[:public_phone_number]
          phone = office[:public_phone_number]
          formatted_phone = "(" + phone[0, 3] + ") " + phone[3, 3] + "-" + phone[6, 4]
        end

        name = "#{office[:office_name]} #{office[:office_type]}"
        capitalized_name = name.split.map(&:capitalize).join(' ')

        address_city = "#{office[:street_address_line_1]} #{office[:city]}"
        capitalized_address_city = address_city.split.map(&:capitalize).join(' ')
        full_address = capitalized_address_city + " #{office[:state]} #{office[:zip_code]}"
        # NOTE: see note above

        Facility.new(
          name: capitalized_name,
          address: full_address,
          phone: formatted_phone
        )

      when "MO"
        # NOTE: Could refactor into helper methods:
        address_city = "#{office[:address1]} #{office[:city]}"
        capitalized_address_city = address_city.split.map(&:capitalize).join(' ')
        full_address = capitalized_address_city + " #{office[:state]} #{office[:zipcode]}"
        # NOTE: see note above

        Facility.new(
          name: "#{office[:name].capitalize} Office",
          address: full_address,
          phone: office[:phone]
        )
      end
    end
  end
end