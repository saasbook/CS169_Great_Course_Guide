class AddCategoryToProfessors < ActiveRecord::Migration
  def change
  	add_column :professors, :category, :string, :default => "EECS"
  end
end
