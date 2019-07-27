class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :number
      t.integer :qty
      t.decimal :total
      t.integer :user_id
      t.string :state

      t.timestamps
    end
  end
end
