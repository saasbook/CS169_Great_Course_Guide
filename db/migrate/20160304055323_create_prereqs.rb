class CreatePrereqs < ActiveRecord::Migration
  def change
    create_table :prereqs do |t|
      t.integer :course_id
      t.integer :prereq_id
    end
  end
end
