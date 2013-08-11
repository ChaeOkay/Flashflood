class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck


  # def get_cards
  #   @cards = Deck.find_by_id(deck_id).cards.shuffle
  # end

  # def cards
  #   @cards.shuffle
  # end

  # def choose_card
  #   @current_card = @cards.pop
  # end

  # def current_card
  #   @current_card
  # end



  def next_card
    self.card_counter += 1
    self.save

    current_card #=> returns a card object
  end

  def reset_card
    self.card_counter = 0
    self.save
  end

  # def current_card
  #   cards.cards[card_counter] #@card_counter
  # end

  def last_card?
    card_counter == (deck_length-1)
  end

  def deck_length
    Deck.find_by_id(deck_id).cards.length
  end

end
