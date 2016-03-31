class AddDistinguishedYearToProfessor < ActiveRecord::Migration
  def change
  	add_column :professors, :distinguishedYear, :string, null: true
  end
end
