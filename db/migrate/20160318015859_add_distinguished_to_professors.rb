class AddDistinguishedToProfessors < ActiveRecord::Migration
  def change
  	add_column :professors, :distinguished, :boolean, :default => false
  end
end
