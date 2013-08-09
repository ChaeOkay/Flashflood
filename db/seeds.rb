# martino = User.create(username: 'Martino')
# martino.password= 'crazy'
# martino.save
# state_capitals = Deck.create(name: 'State Capitals')

# ca = Card.create(question: 'What is the capital of California?', answer: 'Sacramento')
# mi = Card.create(question: 'What is the capital of Michigan?', answer: 'Lansing')
# pa = Card.create(question: 'What is the capital of Pennsyvania?', answer: 'Harrisburg')


# state_capitals.cards.create(question: 'What is the capital of California?', answer: 'Sacramento')
# state_capitals.cards << mi
# state_capitals.cards << pa

# martino.decks << state_capitals

# round = Round.where(user_id: martino[:id], deck_id: state_capitals[:id])
# # round.num_correct = 1
# # round.num_incorrect = 3


country_capitals = Deck.create(name: 'Country Capitals')
Deck.find_by_name('Deck Capitals').destroy
