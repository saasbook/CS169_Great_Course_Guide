class AddAwardedToProfessors < ActiveRecord::Migration
  def change
  	add_column :professors, :awarded, :boolean
  end
end
