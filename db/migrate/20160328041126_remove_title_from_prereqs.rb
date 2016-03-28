class RemoveTitleFromPrereqs < ActiveRecord::Migration
  def change
    remove_column :prereqs, :title
  end
end
