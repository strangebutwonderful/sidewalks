class Neighborhood
  @@cities = {
    sanfrancisco: {
      latitude: "37.7833",
      longitude: "-122.4167",
      name: "San Francisco"
    }
  }

  @@districts = {
    castro: {
      latitude: "37.7617",
      longitude: "-122.4351",
      name: "Castro"
    },
    civiccenter: {
      latitude: "37.7793",
      longitude: "-122.4175",
      name: "Civic Center"
    },
    financialdistrict: {
      latitude: "37.7952",
      longitude: "-122.4029",
      name: "Financial District"
    },
    fishermanswharf: {
      latitude: "37.8083",
      longitude: "-122.4156",
      name: "Fisherman's Wharf"
    },
    haightashbury: {
      latitude: "37.7700",
      longitude: "-122.4469",
      name: "Haight-Ashbury"
    },
    hayesvalley: {
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
    nobnill: {
      latitude: "37.7932",
      longitude: "-122.4145",
      name: "Nob Hill"
    },
    northbeach: {
      latitude: "37.8003",
      longitude: "-122.4102",
      name: "North Beach"
    },
    pacheights: {
      latitude: "37.7917",
      longitude: "-122.4356",
      name: "Pacific Heights"
    },
    potrerohill: {
      latitude: "37.7572",
      longitude: "-122.3999",
      name: "Potrero Hill"
    },
    richmond: {
      latitude: "37.7778",
      longitude: "-122.4828",
      name: "The Richmond"
    },
    russianhill: {
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
    unionsquare: {
      latitude: "37.7881",
      longitude: "-122.4075",
      name: "Union Square"
    },
  }

  def self.city(key)
    if @@cities[key].present?
      OpenStruct.new(@@cities[key])
    else
      nil
    end
  end

  def self.city_latlng(key)
    city = Neighborhood.city(key)

    if city.present?
      LatLng.new(city.latitude, city.longitude)
    else
      nil
    end
  end

  def self.districts
    unless @districts
      @districts = []
      @@districts.each do |key, district|
        @districts << OpenStruct.new(district)
      end
    end

    @districts
  end

end
