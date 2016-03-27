class AddTakeToUserCourses < ActiveRecord::Migration
  def change
    add_column :user_courses, :taken, :boolean
  end
end
