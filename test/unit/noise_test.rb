require 'test_helper'

class NoiseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "FactoryGirl works" do
    assert_difference('Noise.count') do
      noise = FactoryGirl.create(:noise)  
    end
  end

  test "imports raw twitter object" do
    importable_noiselike_object = OpenStruct.new(
      FactoryGirl.attributes_for(:noise)
    )

    user = FactoryGirl.create(:user)
    noise = Noise.new

    assert noise.import_from_twitter_noise(importable_noiselike_object, user)
  end

  test "imports noise when new noise" do
    importable_noiselike_object = OpenStruct.new(
      FactoryGirl.attributes_for(:noise)
    )

    user = FactoryGirl.create(:user)

    assert Noise.first_or_import_from_twitter_noise(importable_noiselike_object, user)
  end

  test "imports noise when old noise" do
    noise = FactoryGirl.create(:noise)

    importable_noiselike_object = OpenStruct.new(
      noise.attributes
    )

    user = FactoryGirl.create(:user)

    assert Noise.first_or_import_from_twitter_noise(importable_noiselike_object, user)
  end
end
