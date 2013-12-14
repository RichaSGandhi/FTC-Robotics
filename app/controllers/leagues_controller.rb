class LeaguesController < ApplicationController
before_filter :set_current_user
def index
     check_access_user_Admins
     @leagues = League.all
end

def show
    check_access_user_Admins
    @league = League.find(params[:id])
    @teams_nos = @league[:team_no].split(',')
    @coach_hash = Hash.new()
    @teams_nos.each do |team_no|
	@team = Team.find_by_team(team_no)
	@coach_hash[@team[:team]] = @team[:main_contact]
    end	    
end



def edit
    check_access_user_global
    @league = League.find(params[:id])
end

  
def create   
 @teams_all= Team.all
 geo_hash= Hash.new()
 geo_hash = generate_geocoded_address(@teams_all)
   leagueNamesArray = ["Applebot","Kiwibot","Bananabot","Orangebot","Raspbot","Cherrybot","Rubybot","Pumpkinbot","Grapebot","Lemonbot","Limebot","Blackbot","Yellowbot", "Pinkbot", "Cocobot","Graybot","Whitebot","Redbot","Greenbot","Muskbot", "Waterbot", "Brownbot", "Almondbot", "Cashewbot", "Walnutbot", "Rasinbot", "Honeybot", "Rainbot", "Snowbot", "Flurbot", "Fallbot", "Summerbot", "Winterbot", "Springbot"]
   i=-1

   @teams_all.each do |team|	
        @leagueName = String.new()
	@league = Array.new()
	@team_nos = String.new()
	 if team[:league_name] == nil and team[:main_contact_postal_code] !=nil
          i+=1
         @leagueName = leagueNamesArray[i] 
	 @league.push(team[:team])
	 @team_nos.concat("#{team[:team]}")
	 team.update_attributes!(:league_name => @leagueName)
         team.save!         
	 @centre = geo_hash[team[:team]]
	 @initial_radi = 50
	 @hash_leag = Hash.new()
	 @hash_leag = add_teams_to_leagues(@league, @centre, @initial_radi, @leagueName,geo_hash,@team_nos)
	 @team_nos = @hash_leag["team_num"]
	 @league = @hash_leag["league_new"]

	@radius = @initial_radi
        while (true) do
	if @league.length < 8 && @radius <= 150
	 @hash_all= Hash.new()
	 @radius = @radius+25
	 @hash_all= add_teams_to_leagues(@league, @centre, @radius, @leagueName,geo_hash,@team_nos)
	 @team_nos = @hash_all["team_num"]
	 @league = @hash_all["league_new"]
	else
	 break
	end
end
	League.create_league!(@team_nos,@leagueName)
        end	
	
    end #outer do ends-
	redirect_to teams_path	
end

def add_teams_to_leagues(league,centre,radius,leagueName,geo_hash,team_nos)
	hash_all = Hash.new()
	@teams_all.each do |teamtest|
	   if league.length < 16 
		    if teamtest[:league_name] == nil && teamtest[:main_contact_postal_code] !=nil && !league.include?(teamtest[:team])
			      @test_if_in_radius = geo_hash[teamtest[:team]]
			      distance = centre.distance_to(@test_if_in_radius)
                              #sleep(6)
			      if distance < radius
				        league.push(teamtest[:team])
					team_nos.concat(", #{teamtest[:team]}")
					teamtest.update_attributes!(:league_name => leagueName)
					teamtest.save!
					test = Team.find_by_team(teamtest[:team])
			      end
		     end
            else
		break
            end            
          end #inner each ends
	hash_all["team_num"] = team_nos
	hash_all["league_new"] = league
	return hash_all

end


def generate_geocoded_address(teams)
hash = Hash.new()
teams.each do |team|
if(team[:main_contact_postal_code] !=nil)
  hash[team[:team]] = Geokit::Geocoders::GoogleGeocoder3.geocode("#{team[:main_contact_postal_code]}")
  sleep(6)
end
end
return hash
end

  # PUT /leagues/1
def update
   @league = League.find(params[:id])
   if !params[:coach_name].nil?    
   @league.update_attributes!(:league_admin => params[:coach_name])
   else
   @league.update_attributes!(params[:league])
   @team = Team.find_all_by_league_name
   end
   @AdminInfo = Team.find_by_main_contact(params[:coach_name])
   if !@AdminInfo.nil?
   User.create_leagueAdmin!(@AdminInfo)
   end
   redirect_to leagues_path
end

def export
 send_data(League.to_csv, :type => 'test/csv', :filename => 'leagues.csv')
end

  # DELETE /leagues/1
def destroy
   
    @league = League.find(params[:id])
    @league.destroy
end

end
