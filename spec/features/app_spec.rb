require 'spec_helper'

describe "My Sinatra Application" do
  it "should allow accessing the home page" do
    visit  '/'    #root
    page.should have_content "Flashflood"
  end
end

#put all integration tests into folder called features
