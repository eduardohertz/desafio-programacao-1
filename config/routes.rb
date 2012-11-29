Myfreecomm::Application.routes.draw do

  resources :entries, except: [:show]
	get '/entries/:token' => 'entries#show', as: 'entry'

  root :to => 'entries#index'

end
