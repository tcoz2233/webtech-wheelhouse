class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.string :role, null: false, default: "counter"
      t.references :mechanic, null: true, foreign_key: true, index: { unique: true }

      t.timestamps
    end
    add_index :users, :email_address, unique: true, name: "index_users_on_lower_email_address"
  end
end

class AddUserToRepairs < ActiveRecord::Migration[8.0]
  def change
    add_reference :repairs, :user, null: true, foreign_key: true
  end
end