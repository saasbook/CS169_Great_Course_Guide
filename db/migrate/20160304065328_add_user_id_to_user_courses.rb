class AddUserIdToUserCourses < ActiveRecord::Migration
  def change
    add_column :user_courses, :user_id, :integer
  end
end
