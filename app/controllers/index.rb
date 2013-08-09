get '/' do
  # Look in app/views/index.erb
  erb :sign_in
end

get '/sign_up' do

  erb :sign_up
end

post '/sign_up' do

  erb :dashboard
end

get '/:user_id/dashboard' do

  erb :dashboard
end

get '/:user_id/deck/:id/:card_id' do

  erb :game
end

post '/:user_id/deck/:id/:card_id' do

  erb :game
end

get '/logout' do

  erb :logout
end
