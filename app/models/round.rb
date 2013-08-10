class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck

  #attr_reader :current_card, :cards_remaining

 #@card_counter #=> number associated with index of card object in deck.cards array

  def next_card
    card_counter += 1
    Deck.find_by_id(deck_id).cards[card_counter] #=> returns a card object
  end

  def current_card
    Deck.find_by_id(deck_id).cards[card_counter] #@card_counter
  end

  def last_card?
    card_counter == (Deck.find_by_id(deck_id).cards.length-1)
  end

end
