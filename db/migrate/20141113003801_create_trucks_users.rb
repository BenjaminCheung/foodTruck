class CreateTrucksUsers < ActiveRecord::Migration
  def change
    create_table :trucks_users do |t|
      t.integer :truck_id
      t.integer :user_id
    end
  end
end
