class CreateUsers < ActiveRecord::Migration
  def up
      create_table :users do |t|
      t.string :user_id
      t.string :email
      t.string :role
      t.string :password
      t.string :session_token
      t.string :updatedProfile
      t.string :password_digest	
     t.timestamps
      # Add fields that let Rails automatically keep track
      # of when users are added or modified:
end
end
  def down
      drop_table :users
  end
end

