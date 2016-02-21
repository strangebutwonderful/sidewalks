class SetLocationDefaultCityAndState < ActiveRecord::Migration
  def up
    change_column_default :locations, :city, "San Francisco"
    change_column_default :locations, :state, "CA"
  end

  def down
    change_column_default :locations, :city, nil
    change_column_default :locations, :state, nil
  end
end
