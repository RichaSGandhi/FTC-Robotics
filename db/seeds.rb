# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teams = [{:team => '123', :organization => 'UIowa', :city => 'Iowa', :state => 'Iowa', :date_Registered => '5-Nov-2013'}]

teams.each do |t|
Team.create!({:team => '123', :organization => 'UIowa', :city => 'Iowa', :state => 'Iowa', :date_Registered => '5-Nov-2013'})
end
