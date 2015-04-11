class CreateApnsToken < ActiveRecord::Migration
  def change
    create_table :apns_tokens do |t|
      t.text :device_id
      t.text :apns_token
      t.timestamps
    end

    add_index :apns_tokens, :device_id, unique: true
  end
end
