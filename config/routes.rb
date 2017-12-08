Rails.application.routes.draw do

  root 'static_pages#home'
  resources :users, :only => [:show]

  get '/auth/twitter/callback', to:'twitter_sessions#create'
  get '/auth/failure', to:'twitter_sessions#failure'

  get '/logout', to:'twitter_sessions#destroy'
  get '/about', to:'static_pages#about'

  #get '/quests', to:'quests#show'
  #delete '/quests/destroy', to:'quests#destroy'

  #get '/sandbox', to:'static_pages#sandbox'

  #post '/senddm', to:'users#senddm'

end
