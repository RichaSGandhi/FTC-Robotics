require 'spec_helper'

describe User do
  describe 'Check for create_user' do
    it 'There should be an upload method in User model' do
      User.should respond_to :create_user!
      end
   end
end
