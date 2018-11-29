class AddAuthorsToPapers < ActiveRecord::Migration[5.2]
  def change
    add_column :papers, :author, :string
  end
end
