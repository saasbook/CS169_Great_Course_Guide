class FixCourseNumber < ActiveRecord::Migration
  def change
    change_column :courses, :number, :string, unique: true
  end
end
