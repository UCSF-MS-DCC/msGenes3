class AddIsRecapPermittedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :can_view_redcap, :boolean
  end
end
