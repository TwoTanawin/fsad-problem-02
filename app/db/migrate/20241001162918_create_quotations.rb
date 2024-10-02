class CreateQuotations < ActiveRecord::Migration[7.2]
  def change
    create_table :quotations do |t|
      t.string :author_name
      t.string :quote
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
