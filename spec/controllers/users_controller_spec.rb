require 'spec_helper'

describe UsersController do

describe 'provide proper access right'do

it 'should search for League admin in leagues tables' do
 league = double('league1')
 League.should_find(:find__by_league_admin).and_return(league)
 get :find__by_league_admin, {:id=> league.id}
end

end

end



