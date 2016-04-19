class RenamingAwardColumn < ActiveRecord::Migration
  def change
  	rename_column :awards, :professor_id_id, :professor_id
  end
end
