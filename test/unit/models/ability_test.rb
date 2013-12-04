require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "admin can manage noise" do
    user = FactoryGirl.create(:admin_user)
    ability = Ability.new(user)

    assert ability.can?(:manage, FactoryGirl.create(:noise))
  end

  test "user cannot update noise" do
    user = FactoryGirl.create(:user)
    ability = Ability.new(user)

    assert ability.cannot?(:update, FactoryGirl.create(:noise))
  end

  test "user cannot destroy noise" do
    user = FactoryGirl.create(:user)
    ability = Ability.new(user)

    assert ability.cannot?(:destroy, FactoryGirl.create(:noise))
  end

end