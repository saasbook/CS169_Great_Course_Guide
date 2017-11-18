class CreateBtFilters < ActiveRecord::Migration
  def change
    create_table :bt_filters do |t|
      t.string :filter
      t.string :category
      t.string :filter_id

      t.timestamps null: false
    end
  end
end
