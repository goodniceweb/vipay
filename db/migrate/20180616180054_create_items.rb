class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :party, foreign_key: true
      t.string :amount
      t.string :price
      t.string :total

      t.timestamps
    end
  end
end
