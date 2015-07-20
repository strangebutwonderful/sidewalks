class Neighborhood

  DISTRICTS = {
    castro: {
      latitude: "37.7617",
      longitude: "-122.4351",
      name: "Castro"
    },
    civic_center: {
      latitude: "37.7793",
      longitude: "-122.4175",
      name: "Civic Center"
    },
    financial_district: {
      latitude: "37.7952",
      longitude: "-122.4029",
      name: "Financial District"
    },
    fishermans_wharf: {
      latitude: "37.8083",
      longitude: "-122.4156",
      name: "Fisherman's Wharf"
    },
    haight_ashbury: {
      latitude: "37.7700",
      longitude: "-122.4469",
      name: "Haight-Ashbury"
    },
    hayes_valley: {
      latitude: "37.7730",
      longitude: "-122.4283",
      name: "Hayes Valley"
    },
    marina: {
      latitude: "37.8030",
      longitude: "-122.4360",
      name: "The Marina"
    },
    mission: {
      latitude: "37.7600",
      longitude: "-122.4200",
      name: "The Mission"
    },
    nob_hill: {
      latitude: "37.7932",
      longitude: "-122.4145",
      name: "Nob Hill"
    },
    north_beach: {
      latitude: "37.8003",
      longitude: "-122.4102",
      name: "North Beach"
    },
    pac_heights: {
      latitude: "37.7917",
      longitude: "-122.4356",
      name: "Pacific Heights"
    },
    potrero_hill: {
      latitude: "37.7572",
      longitude: "-122.3999",
      name: "Potrero Hill"
    },
    richmond: {
      latitude: "37.7778",
      longitude: "-122.4828",
      name: "The Richmond"
    },
    russian_hill: {
      latitude: "37.8018",
      longitude: "-122.4198",
      name: "Russian Hill"
    },
    soma: {
      latitude: "37.7772",
      longitude: "-122.4111",
      name: "SOMA"
    },
    sunset: {
      latitude: "37.7500",
      longitude: "-122.4900",
      name: "The Sunset"
    },
    union_square: {
      latitude: "37.7881",
      longitude: "-122.4075",
      name: "Union Square"
    },
  }

  def self.districts
    unless @districts
      @districts = []
      DISTRICTS.each do |key, district|
        @districts << OpenStruct.new(district)
      end
    end

    @districts
  end

end
