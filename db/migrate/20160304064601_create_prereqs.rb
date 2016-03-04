class CreatePrereqs < ActiveRecord::Migration
  def change
    create_table :prereqs do |t|
      t.string :number
      t.string :title
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
