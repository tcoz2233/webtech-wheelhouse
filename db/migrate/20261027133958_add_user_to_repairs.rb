class AddUserToRepairs < ActiveRecord::Migration[8.0]
  def change
    add_reference :repairs, :user, null: true, foreign_key: true
  end
end