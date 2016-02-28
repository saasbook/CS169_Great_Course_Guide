class AddUseridToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :user_id, :Integer
  end
end
