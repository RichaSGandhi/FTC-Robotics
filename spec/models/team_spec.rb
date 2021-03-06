require 'spec_helper'

describe Team do
  describe 'Check for create_team' do
    it 'There should be an upload method in Team model' do
      Team.should respond_to :upload
      end
    it 'There should be an create_team! method in Team model' do
      Team.should respond_to :create_team!
      end
    it 'There should be an upload method' do
      Team.should respond_to :upload
      end
  end
end
