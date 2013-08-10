require 'spec_helper'

describe User do
  context 'creating a new user' do
    params = { username: 'Colleen',
                      password: 'crazy'}
    let(:user) { User.create(params) }


    it  "should have a user name of 'Colleen'" do
      user.username.should == "Colleen"
    end

    it  "should have a password 'crazy'" do
      user.password.should == "crazy"
    end

  end
end
