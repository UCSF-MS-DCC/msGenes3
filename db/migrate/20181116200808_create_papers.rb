class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :title
      t.string :pmid
      t.string :publication
      t.string :pubdate
      t.text :synopsis

      t.timestamps
    end
  end
end
