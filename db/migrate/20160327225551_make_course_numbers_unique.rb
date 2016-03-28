class MakeCourseNumbersUnique < ActiveRecord::Migration
  def change
    change_column :courses, :number, :text, unique: true
  end
end
