class Team < ActiveRecord::Base  
#require 'smarter_csv' 
validates :team, presence: true, :uniqueness => true

def self.import(file)
end

  def self.create_team!(team)	
	Team.create ({:team => team[:team], :organization => team[:organization], :city=>team[:city], :state=>team[:state], :date_registered=> (Time.now).strftime('%m/%d/%Y'), :main_contact=>team[:main_contact], :main_contact_address=>team[:main_contact_address], :main_contact_city=>team[:main_contact_city], :"main_contact_state"=>team[:main_contact_state], :main_contact_postal_code=>team[:main_contact_postal_code], :country=>team[:country], :main_contact_email=>team[:main_contact_email], :main_contact_phone=>team[:main_contact_phone], :county=>team[:county], :organization_type=>team[:organization_type],:school_district=>team[:school_district]})
  end


end
