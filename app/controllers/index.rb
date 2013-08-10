get '/' do
  # Look in app/views/index.erb
  redirect "/sign_in"
end

get "/sign_in" do
  erb :sign_in
end

post "/sign_in" do
  user = User.find_by_username(params[:username])
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
  end

  "already a user"
    # redirect '/:user_id/dashboard'
    # erb :dashboard
end

get '/:user_id/dashboard' do
  @all_decks = Deck.all
  erb :dashboard
end

get '/:user_id/deck/:deck_id/:card_id' do
  # localhost:9393/1/deck/1/3
  # params = { :user_id => value}
  @user = User.find_by_id(params[:user_id])
  @deck = Deck.find_by_id(params[:deck_id])
  @card = @deck.cards.find_by_id(params[:card_id])

  # if @card.question.nil?
  #   redirect "/#{params[:user_id]}/dashboard"
  # else
  #   erb :game
  # end
  erb :game
end

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
