class AddUnitsToCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :units, :integer, :default => 4
  end
end
