get '/' do
  #session[:user_id] = nil
  unless session[:user_id]
    erb :index
  else
    redirect "/#{session[:user_id]}/dashboard"
  end
end

get "/sign_in" do
  unless session[:user_id]
    @show_msg = params[:msg] != nil
    erb :sign_in
  else
    redirect "/#{session[:user_id]}/dashboard"
  end
end

post "/sign_in" do
  user = User.find_by_username(params[:username])
  if not user.nil? and user.password == params[:password]
      session[:user_id] = user.id
      redirect "/#{user.id}/dashboard"
  end
  redirect '/sign_in?msg=Unknown user or password.'
end


get '/sign_up' do
  @show_msg = true if params[:msg] != nil
  erb :sign_up
end



post '/sign_up' do
  unless User.find_by_username(params[:username])
    user = User.create(username: params[:username])
    user.password = params[:password]
    user.save
    redirect "/#{user.id}/dashboard"
  else

  redirect '/sign_up?msg=already_user'
  end
end

get '/sign_out' do
  session[:user_id] = nil
  redirect '/'
end

get '/:user_id/dashboard' do
  if session[:user_id] == params[:user_id].to_i
    @all_decks = Deck.all
    #@users_rounds = Round.where(user_id: params[:user_id])
    @user_id = params[:user_id]
    @no_deck = true if params[:msg] != nil
    erb :dashboard
  else
    redirect '/sign_in'
  end
end

post '/:user_id/dashboard' do
  if session[:user_id] == params[:user_id].to_i
    if params[:deck_id]
      round = Round.find_by_user_id_and_deck_id(params[:user_id], params[:deck_id])
      round = Round.create(user_id: params[:user_id], deck_id: params[:deck_id]) if round.nil?

      round.num_correct = 0
      round.num_incorrect = 0
      round.save

      redirect "/#{params[:user_id]}/round/#{round.id}"
    else
      redirect "/#{params[:user_id]}/dashboard?msg=no_deck"
    end
  else
    redirect '/sign_in'
  end
end

get '/:user_id/round/:round_id' do
  if session[:user_id] == params[:user_id].to_i
    @user_id = params[:user_id]
    @round = Round.find_by_id(params[:round_id])
    @deck = Deck.find_by_id(@round.deck_id)
    @current_card = @round.remaining_cards.first

     
    if params[:msg]
      @last_guess = params[:msg]
      @last_question = @round.guessed_cards.last
    end
    @deck_progress = @round.deck_progress

    puts "*" * 50
    puts "all_cards #{@round.all_cards.length}"
    puts "remaining_cards #{@round.remaining_cards.length}"
    puts "deck_progress #{@deck_progress}"
    puts "*" * 50
    erb :game
  else
    redirect '/sign_in'
  end
end

post '/:user_id/round/:round_id' do
  if session[:user_id] == params[:user_id].to_i

    round = Round.find_by_id(params[:round_id])
    current_card = round.remaining_cards[0]

    guess = Guess.find_by_round_id_and_card_id(round.id, current_card.id)
    
    guess ||= Guess.create(round_id: round.id, card_id: current_card.id)

    
    if params[:guess] == current_card[:answer]
      msg = "correct"
      guess.correct = true
      guess.save 
      
      round.num_correct += 1
      round.save
    else
      guess.correct = false
      guess.save

      msg = "incorrect"
      round.num_incorrect += 1
      round.save
    end

    unless round.remaining_cards.length == 0 #|| round.max_guesses <= round.num_incorrect
      redirect "/#{params[:user_id]}/round/#{round.id}?msg=#{msg}"
    else
      @deck_progress = round.deck_progress
      round.reset_guessed_cards
      round.round_count += 1
      round.save
      @round = round
      @deck = Deck.find_by_id(@round.deck_id)
      @user_id = params[:user_id]

      erb :summary_page
    end
  else
    redirect '/sign_in'
  end
end



