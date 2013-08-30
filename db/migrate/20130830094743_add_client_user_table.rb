class AddClientUserTable < ActiveRecord::Migration
  def change
    create_table :clients_users do |t|
      t.integer :client_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
