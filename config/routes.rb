Myfreecomm::Application.routes.draw do

  resources :balances

  root :to => 'balances#index'

end
