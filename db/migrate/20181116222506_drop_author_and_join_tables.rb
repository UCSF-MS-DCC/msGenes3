class DropAuthorAndJoinTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :author_papers
    drop_table :authors
  end
end
