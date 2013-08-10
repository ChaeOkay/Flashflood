require 'spec_helper'

describe Round do
  let(:round) { Round.create(:user_id => 1, :deck_id => 1) }

  context "when a selects a deck" do

    it "should have default num_correct & num_incorret values of 0" do
      round.num_correct.should == 0
      round.num_incorrect.should == 0
    end

    it "should have a default card counter value of 0" do
      round.card_counter.should == 0
    end

  end
end
