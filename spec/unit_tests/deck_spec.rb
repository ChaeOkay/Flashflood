require 'spec_helper'

describe Deck do
  let(:deck) { Deck.create(name: 'State Capitals') }

  it "should have a name" do
    deck.name.should == 'State Capitals'
  end

end
