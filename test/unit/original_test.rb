# == Schema Information
#
# Table name: originals
#
#  id              :integer          not null, primary key
#  importable_id   :integer          not null
#  importable_type :string(255)      not null
#  dump            :json             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class OriginalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "FactoryGirl works for noise's original" do
    assert_difference('Original.count') do
      FactoryGirl.create(:noise_original)
    end
  end

  test "FactoryGirl works for user's original" do
    assert_difference('Original.count') do
      FactoryGirl.create(:user_original)
    end
  end
end
