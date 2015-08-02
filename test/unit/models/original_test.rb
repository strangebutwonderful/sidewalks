# == Schema Information
#
# Table name: originals
#
#  id              :integer          not null, primary key
#  importable_id   :integer          not null
#  importable_type :string(255)      not null
#  dump            :json             not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_originals_on_importable_id_and_importable_type  (importable_id,importable_type)
#

require 'test_helper'

class OriginalTest < ActiveSupport::TestCase
  test "FactoryGirl works for noise's original" do
    assert_difference ->{ Original.count } do
      FactoryGirl.create(:noise_original)
    end
  end

  test "FactoryGirl works for user's original" do
    assert_difference ->{ Original.count } do
      FactoryGirl.create(:user_original)
    end
  end
end
