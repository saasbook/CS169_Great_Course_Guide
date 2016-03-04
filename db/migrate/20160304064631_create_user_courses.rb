class CreateUserCourses < ActiveRecord::Migration
  def change
    create_table :user_courses do |t|
      t.string :number
      t.string :title
      t.string :uid

      t.timestamps null: false
    end
  end
end
