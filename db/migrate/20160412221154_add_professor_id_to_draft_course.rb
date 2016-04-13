class AddProfessorIdToDraftCourse < ActiveRecord::Migration
  def change
    add_column :draft_courses, :professor_id, :integer
  end
end
