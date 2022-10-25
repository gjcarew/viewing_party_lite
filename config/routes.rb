Rails.application.routes.draw do
  root to: 'users#welcome'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'

  resource :users, path: 'dashboard', as: 'user' 

  get '/dashboard/discover', to: 'users#discover'
  get '/dashboard/movies/:movie_id', to: 'movies#show'
  get '/dashboard/movies', to: 'users#results'
  get '/dashboard/movies/:movie_id/viewing-party/new', to: 'user_parties#new'
  post '/dashboard/movies/:movie_id/create', to: 'user_parties#create'
end
