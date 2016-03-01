class AddCourseNumberToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_number, :string
  end
end
