class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :category
      t.string :amount
      t.boolean :transaction_status
      t.string :name
      t.integer :worker_id
      t.timestamps
    end
  end
end
