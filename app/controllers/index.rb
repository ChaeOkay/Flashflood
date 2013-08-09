get '/' do
  # Look in app/views/index.erb
  erb :sign_in
end

post "/sign_in" do
  user = User.find_by_username(params[:username])
  puts user.nil?
  unless user.nil?
    if user.password == params[:password]
      # session[:user_id] = user.id

      erb :dashboard

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

  erb :dashboard
end

get '/:user_id/deck/:deck_id/:card_id' do
  # localhost:9393/1/deck/1/1
  # params = { :user_id => value}
  user = User.find_by_id(params[:user_id])
  @deck = Deck.find_by_id(params[:deck_id])
  cardid = deck.cards.find_by_id(params[:card_id])

  erb :game
end

post '/:user_id/deck/:deck_id/:card_id' do

  erb :game
end

get '/logout' do

  erb :logout
end
