class RemoveUidFromUserCourses < ActiveRecord::Migration
  def change
    remove_column :user_courses, :uid, :string
  end
end
