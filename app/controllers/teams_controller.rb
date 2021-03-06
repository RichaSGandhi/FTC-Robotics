class TeamsController < ApplicationController
before_filter :set_current_user
 

require 'geokit-rails'


def index
  check_access_user_global
  @teams= Team.all    
end

def edit
@team = Team.find_by_team(@current_user.user_id)
 # default: render 'edit' templat
end

def new
    # default: render 'new' template
end

def show
 check_access_user_Team(params[:id])
 @team_no = @current_user.user_id
 @eventsregistered = Eventregistration.find_all_by_team_no(@current_user.user_id)
end


def create
   @team = Team.create_team!(params[:team])
   exist = @team[:id]
   puts exist
   if exist
        @user = Team.create_user!(params[:team])
	flash[:notice] = "Welcome #{@team.team}. Your account has been created, Please use your team no as password to login"	
	redirect_to login_path	
  
   else
	flash[:notice] = " Sorry -- #{@team.errors.full_messages}.Try again"
	redirect_to new_team_path
   end
 end

 def import  
  if(params[:file] == nil)
	flash[:notice] ="Sorry! No file selected. Please select a file and try again."
	redirect_to users_path
  else
       teams = Team.upload(params[:file].path) 
       @message = String.new   
       teams.each do |team|
	       if !(team.errors).empty?
		@message.concat("Sorry --#{team.team} was not added because of following erros #{team.errors.full_messages}.")
	       end
       end
        if @message.empty?
        flash[:notice] = "Team data Uploaded"	
	redirect_to teams_path 
        else
        flash[:notice] = "#{@message}.Please try again"
        redirect_to teams_path     
        end
  end
end
 
 def export
 send_data(Team.to_csv, :type => 'test/csv', :filename => 'teams.csv')
 end

def update
    @team =Team.update_att(params)
    #@team = Team.find_by_team(@current_user.user_id)
    #@team.update_attributes!(params[:team])
    if @team.save
      flash[:notice] = "Profile was successfully updated. "
      redirect_to team_path(@current_user.user_id)
   else
	flash[:notice] = " Sorry -- #{@team.errors.full_messages}.Try again"
	redirect_to edit_team_path(@current_user.user_id)

    end

end

def remove
if params[:selected_teams].nil?
flash[:notice] = "Sorry !! Teams can't be deleted after leagues are generated"
  redirect_to teams_path
else
 arrteamid = params[:selected_teams].keys
   arrteamid.each do |id|
  Team.destroy(id)
  end
  flash[:notice] = "Team successfully deleted"
  redirect_to teams_path 
end
end

end
