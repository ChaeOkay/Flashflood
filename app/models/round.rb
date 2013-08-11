class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck

  has_many :guesses
  has_many :cards, through: :guesses


  def remaining_cards
    remaining_cards = all_cards - guessed_cards
    #remaining_cards.shuffle
  end

  def guessed_cards
    guessed_cards = []
    Guess.where(round_id: id).each do |guess| #push in only cards that were right
      guessed_cards << Card.find_by_id(guess.card_id) 
    end
    guessed_cards
  end

  def all_cards
    Deck.find_by_id(deck_id).cards
  end

  def no_cards?
    remaining_cards == 1
  end

  def reset_guessed_cards
    Guess.where(round_id: id).each do |guess|
      guess.destroy
    end
  end

  def deck_progress
    numerator = (all_cards.length - remaining_cards.length).to_f
    (numerator/all_cards.length) * 100
  end
end
