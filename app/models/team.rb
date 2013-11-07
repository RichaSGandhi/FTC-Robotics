class Team < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.upload(file)
    data = SmarterCSV.process(file)    
    data.each do |team|	
	team[:date_registered]= DateTime.strptime(team[:date_registered], "%m/%d/%Y")
	Team.create!(team)
    end
  end
end 
