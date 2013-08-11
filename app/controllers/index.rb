get '/' do
  unless session[:user_id]
    erb :index
  else
    redirect "/#{session[:user_id]}/dashboard"
  end
end

get "/sign_in" do
  unless session[:user_id]
    @show_msg = params[:msg] != nil
  #  @msg = params[:msg]
    erb :sign_in
  else
    redirect "/#{session[:user_id]}/dashboard"
  end
end

post "/sign_in" do
  user = User.find_by_username(params[:username])
  if not user.nil? and user.password == params[:password]
      # session[:user_id] = user.id
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
    user = User.new(username: params[:username])
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
    @user_id = params[:user_id]
    erb :dashboard
  else
    redirect '/sign_in'
  end
end

post '/:user_id/dashboard' do
  if session[:user_id] == params[:user_id].to_i
    round = Round.find_by_user_id_and_deck_id(params[:user_id], params[:deck_id])
    round = Round.create(user_id: params[:user_id], deck_id: params[:deck_id]) if round.nil?

    round.num_correct = 0
    round.num_incorrect = 0
    round.save

    redirect "/#{params[:user_id]}/round/#{round.id}"
  else
    redirect '/sign_in'
  end
end

get '/:user_id/round/:round_id' do
  if session[:user_id] == params[:user_id].to_i
    @user_id = params[:user_id]
    @round = Round.find_by_id(params[:round_id])
    @deck = Deck.find_by_id(@round.deck_id)


    @current_card = @round.current_card

    @guesses_remaining = @round.max_guesses - @round.num_incorrect
    @deck_progress = (@round.card_counter.to_f/@round.deck_length)*100
    @deck_progress.to_i

    erb :game
  else
    redirect '/sign_in'
  end
end

post '/:user_id/round/:round_id' do
  if session[:user_id] == params[:user_id].to_i

    round = Round.find_by_id(params[:round_id])
    if params[:guess] == round.current_card[:answer]
      puts "correct"
      round.num_correct += 1
      round.save
    else
      puts "wrong"
      round.num_incorrect += 1
      round.save
    end

    unless round.last_card? || round.max_guesses <= round.num_incorrect
      round.next_card
      redirect "/#{params[:user_id]}/round/#{round.id}"
    else
      @round = round
      @deck = Deck.find_by_id(@round.deck_id)
      round.reset_card
      erb :summary_page
    end
  else
    redirect '/sign_in'
  end
end



