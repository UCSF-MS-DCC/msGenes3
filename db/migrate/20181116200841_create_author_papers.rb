class CreateAuthorPapers < ActiveRecord::Migration[5.2]
  def change
    create_table :author_papers do |t|
      t.references :author, foreign_key: true
      t.references :paper, foreign_key: true

      t.timestamps
    end
  end
end
