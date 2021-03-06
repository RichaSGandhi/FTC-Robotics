class SessionsController < ApplicationController
before_filter :set_current_user

def new
    # default: render 'new' template
end

def create
	@user = User.new(params[:user])
	exist= User.find_by_user_id(params[:user][:user_id])#, :conditions => ["user_id = ?" , @user[:user_id]])
        if exist && exist.authenticate(params[:user][:password])
	   session[:session_token] = exist.session_token
            if exist.role == "Global_Admin"
            flash[:notice] = "Hi!! Becca You are on Global Admin Home Page."
	    redirect_to users_path
            end
            if exist.role == "Team_Member"  
		@team_info = Team.find_by_team(exist.user_id)
		if @team_info[:city] == nil
  		  flash[:notice] = "Please fill up all the details before continuing. #{@team_info[:city]}"
  		  redirect_to edit_team_path(exist.user_id)
             #if exist.updatedProfile == 'no'
              #flash[:notice] = "Hi!! #{@user.user_id} Please update your profile"
              #redirect_to edit_team_path(1234)
             else
              flash[:notice] = "Hi!! #{@user.user_id} You are on your team's Home Page."
              redirect_to team_path(@user.user_id)
             end
           end
           if exist.role == "League_Admin"
              flash[:notice] = "Hi!! #{@user.user_id} You have successfully logged on to League Admin's Home Page"
              redirect_to user_path(@user.user_id)
           end
	else
	  flash[:notice] = "Login/password combination is invalid"
	  redirect_to login_path	
        end   
end

def destroy
  session.clear
  redirect_to login_path
end

end	
  

