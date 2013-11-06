class CreateTeams < ActiveRecord::Migration
  def up
    create_table :teams do |t|
	t.integer :team
	t.text :organization
	t.text :city
	t.text :state
	t.datetime :date_Registered
      t.timestamps
    end
  end

def down
drop_table :teams
end

end
