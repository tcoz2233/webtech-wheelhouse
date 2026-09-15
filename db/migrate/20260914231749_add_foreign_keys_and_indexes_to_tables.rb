class AddForeignKeysAndIndexesToTables < ActiveRecord::Migration[8.0]
  def change

    add_foreign_key :bikes, :customers
    add_index :bikes, :customer_id unless index_exists?(:bikes, :customer_id)

    
    add_foreign_key :repairs, :bikes
    add_index :repairs, :bike_id unless index_exists?(:repairs, :bike_id)

    add_foreign_key :repairs, :mechanics
    unless index_exists?(:repairs, :mechanic_id)
      add_index :repairs, :mechanic_id
    end

  end
end