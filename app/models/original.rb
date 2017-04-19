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

class Original < ApplicationRecord
  belongs_to :importable, polymorphic: true

  validates :importable_id, presence: true
  validates :importable_type, presence: true
  validates :dump, presence: true

  def pretty_dump
    JSON.pretty_generate dump
  end
end
