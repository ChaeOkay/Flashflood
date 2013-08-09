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
  @user_id = params[:user_id]
  erb :dashboard
end

post '/:user_id/dashboard' do

  "#{params[:decks]}"
  first_card = Deck.find_by_id(params[:decks]).cards.first
  p first_card
  redirect "/#{params[:user_id]}/deck/#{params[:decks]}/#{first_card.id}"
end

get '/:user_id/deck/:deck_id/:card_id' do
  # localhost:9393/1/deck/1/3
  # params = { :user_id => value}
  @user = User.find_by_id(params[:user_id])
  @deck = Deck.find_by_id(params[:deck_id])
  @card = @deck.cards.find_by_id(params[:card_id])

  erb :game
end

post '/:user_id/deck/:deck_id/:card_id' do
  guess = params[:guess]
  card = Card.find_by_id(params[:card_id])
  answer = card.answer
  # if guess == answer

  new_id = params[:card_id].to_i + 1
  redirect "/#{params[:user_id]}/deck/#{params[:deck_id]}/#{new_id}"
end

get '/logout' do

  erb :logout
end
