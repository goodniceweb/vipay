class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :participant, foreign_key: true
      t.string :total
      t.boolean :paid

      t.timestamps
    end
  end
end
