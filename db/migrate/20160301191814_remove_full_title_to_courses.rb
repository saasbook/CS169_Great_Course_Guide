class RemoveFullTitleToCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :full_title, :string
  end
end
