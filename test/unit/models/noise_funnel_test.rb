require "test_helper"

class NoiseFunnelTest < ActiveSupport::TestCase

  setup do
    @potrero_hill_funnel = NoiseFunnel.new(
      Neighborhood.districts[:potrero_hill].latitude,
      Neighborhood.districts[:potrero_hill].longitude,
      1.5,
      0.025,
      Time.current,
      1.week.ago,
    )
  end

  test '#noises includes nearby noises that were just created' do
    noise = FactoryGirl.create(
      :noise,
      :potrero_hill,
      created_at: Time.now
    )

    assert_includes(@potrero_hill_funnel.noises, noise)
  end

  test '#noises includes nearby noises that were recently created' do
    noise = FactoryGirl.create(
      :noise,
      :potrero_hill,
      created_at: 1.day.ago
    )

    assert_includes(@potrero_hill_funnel.noises, noise)
  end

  test '#noises does not includes nearby noises that were created too long ago' do
    noise = FactoryGirl.create(
      :noise,
      :potrero_hill,
      created_at: 2.weeks.ago
    )

    assert_not_includes(@potrero_hill_funnel.noises, noise)
  end


end
