# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string(255)      not null
#  email                        :string(255)
#  provider                     :string(255)      not null
#  provider_id                  :string(255)      not null
#  provider_screen_name         :string(255)
#  provider_access_token        :string(255)
#  provider_access_token_secret :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  following                    :boolean          default(FALSE), not null
#  locations_count              :integer          default(0), not null
#

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "FactoryGirl works" do
    assert_difference -> { User.count } do
      FactoryGirl.create(:user)
    end
  end

  test "FactoryGirl admin_user works" do
    assert_difference -> { User.count } do
      FactoryGirl.create(:admin_user)
    end
  end

  test "FactoryGirl user_with_original works" do
    assert_difference -> { User.count } do
      FactoryGirl.create(:user_with_original)
    end
  end

  test "Scope where_needs_triage includes triaged" do
    user = FactoryGirl.create :user, :needs_triage
    assert_includes User.where_needs_triage, user
  end
end
