class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :title
      t.string :year
      t.references :professor_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
