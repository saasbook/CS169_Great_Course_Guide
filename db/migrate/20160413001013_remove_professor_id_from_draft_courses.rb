class RemoveProfessorIdFromDraftCourses < ActiveRecord::Migration
  def change
    remove_column :draft_courses, :professor_id, :integer
  end
end
