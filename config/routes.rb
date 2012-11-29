Myfreecomm::Application.routes.draw do

  devise_for :users
  devise_scope :user do
  	get '/login' => 'devise/sessions#new', as: 'login'
  end

  resources :entries, except: [:show]
	get '/entries/:token' => 'entries#show', as: 'entry'

  root :to => 'entries#index'

end
