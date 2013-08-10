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
   erb :dashboard
  else

  "already a user"
  end  
end

get '/:user_id/dashboard' do
  @all_decks = Deck.all
  @user_id = params[:user_id]
  erb :dashboard
end

post '/:user_id/dashboard' do

  round = Round.find_by_user_id_and_deck_id(params[:user_id], params[:deck_id])
  round = Round.create(user_id: params[:user_id], deck_id: params[:deck_id]) if round.nil? 

  round.num_correct = 0
  round.num_incorrect = 0
  round.save

  redirect "/#{round.id}"
end

get '/:round_id' do
  @round = Round.find_by_id(params[:round_id])
  @deck = Deck.find_by_id(@round.deck_id)
  @current_card = @round.current_card

  @deck_progress = (@round.card_counter.to_f/@round.deck_length)*100
  @deck_progress.to_i

  erb :game
end

post '/:round_id' do
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

  unless round.last_card?
    round.next_card
    redirect "/#{params[:round_id]}"
  else
    @round = round
    @deck = Deck.find_by_id(@round.deck_id)
    round.reset_card
    erb :summary_page
  end
end


get '/logout' do

  erb :logout
end
