class User < ActiveRecord::Base
  # attr_accessible :title, :body
 has_secure_password
 #before_save:create_leagueAdmin!
 validates :password_digest,presence:true

def self.create_leagueAdmin!(leagueAdminInfo)
  session_token=SecureRandom.base64
  User.create! ( {:user_id => leagueAdminInfo[:main_contact], :email => leagueAdminInfo[:main_contact_email],  :role => 'League_Admin', :password => leagueAdminInfo[:main_contact],  :session_token => session_token, :updatedProfile => 'no'})
end

end
