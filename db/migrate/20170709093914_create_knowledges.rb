class CreateKnowledges < ActiveRecord::Migration[5.1]
  def change
    create_table :knowledges do |t|
      t.string :url, null: false
      t.references :word, foreign_key: true

      t.timestamps
    end
  end
end
