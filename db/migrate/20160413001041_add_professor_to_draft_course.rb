class AddProfessorToDraftCourse < ActiveRecord::Migration
  def change
    add_column :draft_courses, :professor, :string
  end
end
