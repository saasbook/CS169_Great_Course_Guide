class CreateDraftCourses < ActiveRecord::Migration
  def change
    create_table :draft_courses do |t|
      t.integer :course_id
      t.string :term

      t.timestamps null: false
    end
  end
end
