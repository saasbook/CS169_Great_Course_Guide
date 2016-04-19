class AddDefaultForAwarded < ActiveRecord::Migration
  def change
  	change_column_default(:professors, :awarded, false)
  end
end
