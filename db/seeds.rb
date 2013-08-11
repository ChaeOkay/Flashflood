martino = User.create(username: 'Martino')
martino.password= 'crazy'
martino.save
state_capitals = Deck.create(name:'State Capitals')

ca = Card.create(question: 'What is the capital of California?', answer: 'Sacramento')
mi = Card.create(question: 'What is the capital of Michigan?', answer: 'Lansing')
ma = Card.create(question: 'What is the capital of Massachusetts?', answer: 'Boston')
co = Card.create(question: 'What is the capital of Colorado?', answer: 'Denver')
ind = Card.create(question: 'What is the capital of Indiana', answer: 'Indianapolis')
oh = Card.create(question: 'What is the capital of Ohio?', answer: 'Columbus')
sc = Card.create(question: 'What is the capital of South Carolina?', answer: 'Columbia')
ky = Card.create(question: 'What is the capital of Kentucky?', answer: 'Frankfort')
wy = Card.create(question: 'What is the capital of Wyoming?', answer: 'Cheyenne')
mt = Card.create(question: 'What is the capital of Montana?', answer: 'Billings')
pa = Card.create(question: 'What is the capital of Pennsylvania?', answer: 'Harrisburg')

state_capitals.cards << ca
state_capitals.cards << mi
state_capitals.cards << pa
state_capitals.cards << co
state_capitals.cards << ind
state_capitals.cards << oh
state_capitals.cards << sc
state_capitals.cards << ky
state_capitals.cards << wy
state_capitals.cards << pa
state_capitals.cards << mt
# decks << state_capitals

# round = Round.where(user_id: martino[:id], deck_id: state_capitals[:id])
# round.num_correct = 1
# round.num_incorrect = 3



college_mascots = Deck.create(name: 'College Mascots')

am = Card.create(question: 'The Boll Weevil is the mascot of which college?', answer: 'Arkansas-Monticello')
cc = Card.create(question: 'The Cobber is the mascot of which college?', answer: 'Concordia College')
wc = Card.create(question: 'The Poet is the mascot of which college?', answer: 'Whittier College')
st = Card.create(question: 'The Billiken is the mascot of which college?', answer: 'St. Louis University')
wu = Card.create(question: 'The Gorlock is the mascot of which college?', answer: 'Webster University')
rc = Card.create(question: 'The Anchormen is the mascot of which college?', answer: 'Rhode Island College')
vt = Card.create(question: 'The Catamount is the mascot of which college?', answer: 'Vermont University')
cs = Card.create(question: 'The Fighting Artichoke is the mascot of which college?', answer: 'Scottsdale Community College')
ak = Card.create(question: 'The Zip is the mascot of which college?', answer: 'Akron')
ds = Card.create(question: 'The Fighting Okra is the mascot of which college?', answer: 'Delta State')

college_mascots.cards << am
college_mascots.cards << cc
college_mascots.cards << wc
college_mascots.cards << st
college_mascots.cards << wu
college_mascots.cards << rc
college_mascots.cards << vt
college_mascots.cards << cs
college_mascots.cards << ak
college_mascots.cards << ds

# Deck.find_by_name('Deck Capitals').destroy
