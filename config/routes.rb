Myfreecomm::Application.routes.draw do

  devise_for :users
  devise_scope :user do
  	get '/login' => 'devise/sessions#new', as: 'login'
  	get '/logout' => 'devise/sessions#destroy', as: 'logout'
  end

  resources :entries, except: [:show]
	get '/entries/:token' => 'entries#show', as: 'entry'

  root :to => 'entries#index'

end
