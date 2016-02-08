class Neighborhood
  DISTRICTS = {
    castro: OpenStruct.new(
      latitude: '37.7617',
      longitude: '-122.4351',
      name: 'Castro'
    ),
    civic_center: OpenStruct.new(
      latitude: '37.7793',
      longitude: '-122.4175',
      name: 'Civic Center'
    ),
    financial_district: OpenStruct.new(
      latitude: '37.7952',
      longitude: '-122.4029',
      name: 'Financial District'
    ),
    fishermans_wharf: OpenStruct.new(
      latitude: '37.8083',
      longitude: '-122.4156',
      name: "Fisherman's Wharf"
    ),
    haight_ashbury: OpenStruct.new(
      latitude: '37.7700',
      longitude: '-122.4469',
      name: 'Haight-Ashbury'
    ),
    hayes_valley: OpenStruct.new(
      latitude: '37.7730',
      longitude: '-122.4283',
      name: 'Hayes Valley'
    ),
    marina: OpenStruct.new(
      latitude: '37.8030',
      longitude: '-122.4360',
      name: 'The Marina'
    ),
    mission: OpenStruct.new(
      latitude: '37.7600',
      longitude: '-122.4200',
      name: 'The Mission'
    ),
    nob_hill: OpenStruct.new(
      latitude: '37.7932',
      longitude: '-122.4145',
      name: 'Nob Hill'
    ),
    north_beach: OpenStruct.new(
      latitude: '37.8003',
      longitude: '-122.4102',
      name: 'North Beach'
    ),
    pac_heights: OpenStruct.new(
      latitude: '37.7917',
      longitude: '-122.4356',
      name: 'Pacific Heights'
    ),
    potrero_hill: OpenStruct.new(
      latitude: '37.7572',
      longitude: '-122.3999',
      name: 'Potrero Hill'
    ),
    richmond: OpenStruct.new(
      latitude: '37.7778',
      longitude: '-122.4828',
      name: 'The Richmond'
    ),
    russian_hill: OpenStruct.new(
      latitude: '37.8018',
      longitude: '-122.4198',
      name: 'Russian Hill'
    ),
    soma: OpenStruct.new(
      latitude: '37.7772',
      longitude: '-122.4111',
      name: 'SOMA'
    ),
    sunset: OpenStruct.new(
      latitude: '37.7500',
      longitude: '-122.4900',
      name: 'The Sunset'
    ),
    union_square: OpenStruct.new(
      latitude: '37.7881',
      longitude: '-122.4075',
      name: 'Union Square'
    )
  }.freeze

  def self.districts
    DISTRICTS
  end
end
