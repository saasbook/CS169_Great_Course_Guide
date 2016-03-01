class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :name
      t.decimal :rating

      t.timestamps null: false
    end
  end
end
