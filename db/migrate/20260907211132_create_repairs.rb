class CreateRepairs < ActiveRecord::Migration[8.1]
  def change
    create_table :repairs do |t|
      t.bigint :bike_id, null: false
      t.bigint :mechanic_id, null: true
      t.string :status, default: 'received', null: false
      t.date :promised_on, null: false
      t.datetime :handed_back_at, null: true
      t.boolean :customer_agreed, null: true

      t.timestamps
    end
  end
end