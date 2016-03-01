class ChangeTypeRatingProf < ActiveRecord::Migration
  def up
    change_column :professors, :rating, :float
  end
end
