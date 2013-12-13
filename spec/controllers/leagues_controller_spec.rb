require 'spec_helper'

describe LeaguesController do

  # This should return the minimal set of attributes required to create a valid
  # League. As you add validations to League, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "league_name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LeaguesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all leagues as @leagues" do
      league = League.create! valid_attributes
      get :index, {}, valid_session
      assigns(:leagues).should eq([league])
    end
  end

  describe "GET show" do
    it "assigns the requested league as @league" do
      league = League.create! valid_attributes
      get :show, {:id => league.to_param}, valid_session
      assigns(:league).should eq(league)
    end
  end

  describe "GET new" do
    it "assigns a new league as @league" do
      get :new, {}, valid_session
      assigns(:league).should be_a_new(League)
    end
  end

  describe "GET edit" do
    it "assigns the requested league as @league" do
      league = League.create! valid_attributes
      get :edit, {:id => league.to_param}, valid_session
      assigns(:league).should eq(league)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new League" do
        expect {
          post :create, {:league => valid_attributes}, valid_session
        }.to change(League, :count).by(1)
      end

      it "assigns a newly created league as @league" do
        post :create, {:league => valid_attributes}, valid_session
        assigns(:league).should be_a(League)
        assigns(:league).should be_persisted
      end

      it "redirects to the created league" do
        post :create, {:league => valid_attributes}, valid_session
        response.should redirect_to(League.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved league as @league" do
        # Trigger the behavior that occurs when invalid params are submitted
        League.any_instance.stub(:save).and_return(false)
        post :create, {:league => { "league_name" => "invalid value" }}, valid_session
        assigns(:league).should be_a_new(League)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        League.any_instance.stub(:save).and_return(false)
        post :create, {:league => { "league_name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested league" do
        league = League.create! valid_attributes
        # Assuming there are no other leagues in the database, this
        # specifies that the League created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        League.any_instance.should_receive(:update_attributes).with({ "league_name" => "MyString" })
        put :update, {:id => league.to_param, :league => { "league_name" => "MyString" }}, valid_session
      end

      it "assigns the requested league as @league" do
        league = League.create! valid_attributes
        put :update, {:id => league.to_param, :league => valid_attributes}, valid_session
        assigns(:league).should eq(league)
      end

      it "redirects to the league" do
        league = League.create! valid_attributes
        put :update, {:id => league.to_param, :league => valid_attributes}, valid_session
        response.should redirect_to(league)
      end
    end

    describe "with invalid params" do
      it "assigns the league as @league" do
        league = League.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        League.any_instance.stub(:save).and_return(false)
        put :update, {:id => league.to_param, :league => { "league_name" => "invalid value" }}, valid_session
        assigns(:league).should eq(league)
      end

      it "re-renders the 'edit' template" do
        league = League.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        League.any_instance.stub(:save).and_return(false)
        put :update, {:id => league.to_param, :league => { "league_name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested league" do
      league = League.create! valid_attributes
      expect {
        delete :destroy, {:id => league.to_param}, valid_session
      }.to change(League, :count).by(-1)
    end

    it "redirects to the leagues list" do
      league = League.create! valid_attributes
      delete :destroy, {:id => league.to_param}, valid_session
      response.should redirect_to(leagues_url)
    end
  end

end
