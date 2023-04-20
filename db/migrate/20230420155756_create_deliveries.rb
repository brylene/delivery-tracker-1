class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.integer :user_id
      t.string :description
      t.date :date
      t.string :details

      t.timestamps
    end
  end
end
