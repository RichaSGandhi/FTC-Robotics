class CreateUsers < ActiveRecord::Migration
  
   def up
    create_table :users do |t|
      t.string :userid
      t.string :password
      t.string :role
      t.timestamps
     end
    
  end
end
