class CreateProfessorCourses < ActiveRecord::Migration
  def change
    create_table :professor_courses do |t|
      t.string :number
      t.string :name
      t.float :rating
      t.string :term
      t.integer :professor_id

      t.timestamps null: false
    end
  end
end
