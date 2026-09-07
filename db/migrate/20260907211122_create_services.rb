class CreateServices < ActiveRecord::Migration[8.1]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.decimal :current_price, precision: 8, scale: 2, null: false
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
    add_index :services, :name, unique: true
  end
end