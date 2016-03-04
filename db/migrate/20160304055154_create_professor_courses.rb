class CreateProfessorCourses < ActiveRecord::Migration
  def change
    create_table :professor_courses do |t|
      t.integer :professor_id
      t.integer :course_id
      t.float :rating
      t.string :term
    end
  end
end
