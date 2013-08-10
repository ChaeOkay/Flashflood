require 'spec_helper'

describe Card do
    let (:card) { ca = Card.create(question: 'What is the capital of California?',
                                                answer: 'Sacramento') }

    it "should have a question" do
      card.question.should == 'What is the capital of California?'
    end

    it "should have an answer" do
      card.answer.should == 'Sacramento'
    end

end
