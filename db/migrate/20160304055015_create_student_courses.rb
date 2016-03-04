class CreateStudentCourses < ActiveRecord::Migration
  def change
    create_table :student_courses do |t|
      t.integer :user_id
      t.integer :course_id
    end
  end
end
