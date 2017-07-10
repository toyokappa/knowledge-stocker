class AddColumnToKnowledge < ActiveRecord::Migration[5.1]
  def change
    add_column :knowledges, :understanding, :integer, default: 0
    add_index :knowledges, :understanding
  end
end
