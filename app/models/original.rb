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

class Original < ActiveRecord::Base
  
  belongs_to :importable, :polymorphic => true
  
  attr_accessible :dump

  validates :importable_id, presence: true
  validates :importable_type, presence: true
  validates :dump, presence: true
  
  validate :dump_is_json_format

  protected

  def dump_is_json_format
    begin
      !!JSON.parse(dump)
    rescue
      errors[:base] << "not in json format"
    end
  end

end
