get '/' do
  # Look in app/views/index.erb
  redirect "/sign_in"
end

get "/sign_in" do
  erb :sign_in
end

post "/sign_in" do
  user = User.find_by_username(params[:username])
  p user
  puts user.nil?
  unless user.nil?
    if user.password == params[:password]
      # session[:user_id] = user.id

      redirect "/#{user.id}/dashboard"

    else
      @reason = "wrong password"
      redirect '/'
    end
  else
    redirect '/'
  end
end


get '/sign_up' do

  erb :sign_up
end



post '/sign_up' do
  unless User.find_by_username(params[:username])
    user = User.new(username: params[:username])
    user.password = params[:password]
    user.save
    p user
   "im in"
  else

  "already a user"
  end  
  
    # erb :dashboard
end

get '/:user_id/dashboard' do
  @all_decks = Deck.all
  @user_id = params[:user_id]
  erb :dashboard
end

post '/:user_id/dashboard' do

  round = Round.find_by_user_id_and_deck_id(params[:user_id], params[:deck_id])
  round = Round.create(user_id: params[:user_id], deck_id: params[:deck_id]) if round.nil? 
  # "#{params[:decks]}"
  # first_card = Deck.find_by_id(params[:decks]).cards.first
  # p first_card
  redirect "/#{round.id}"
end

get '/:round_id' do
  @round = Round.find_by_id(params[:round_id])
  @deck = Deck.find_by_id(@round.deck_id)

  @current_card = @round.current_card
  
  erb :game
end

post '/:round_id' do
  round = Round.find_by_id(params[:round_id])
  if params[:guess] == round.current_card[:answer] 
    round.num_correct += 1
  else 
    round.num_wrong += 1
  end 

  unless round.last_card?
    "it worked"
    #redirect '/:round_id'
  else
    "congratulations, you finished"
    erb :summary_page
  end
end

# get '/:user_id/deck/:deck_id/:card_id' do
#   # localhost:9393/1/deck/1/3
#   # params = { :user_id => value}
#   @user = User.find_by_id(params[:user_id])
#   @deck = Deck.find_by_id(params[:deck_id])
#   @card = @deck.cards.find_by_id(params[:card_id])

#   # if @card.question.nil?
#   #   redirect "/#{params[:user_id]}/dashboard"
#   # else
#   #   erb :game
#   # end
#   erb :game
# end

post '/:user_id/deck/:deck_id/:card_id' do
  guess = params[:guess]
  card = Card.find_by_id(params[:card_id])
  answer = card.answer
  round = Round.where(user_id: params[:user_id], deck_id: params[:deck_id]).first
  if guess == answer
    round.num_correct += 1
  else
    round.num_incorrect += 1
  end
  new_id = params[:card_id].to_i + 1

  redirect "/#{params[:user_id]}/deck/#{params[:deck_id]}/#{new_id}"
end

get '/logout' do

  erb :logout
end
