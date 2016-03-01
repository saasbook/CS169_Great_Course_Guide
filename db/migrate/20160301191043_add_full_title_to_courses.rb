class AddFullTitleToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :full_title, :string
  end
end
