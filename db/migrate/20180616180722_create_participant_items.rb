class CreateParticipantItems < ActiveRecord::Migration[5.1]
  def change
    create_table :participant_items do |t|
      t.references :participant, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :invoice_id
      t.string :amount
      t.string :total

      t.timestamps
    end
    add_index :participant_items, :invoice_id
  end
end
