Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :books, only:[:index, :show]
  # get '/books', to: 'books#index'
  # get '/book/show', to: 'book#show'
  resources :authors, only:[:index, :show]
  # get '/authors', to: 'authors#index'
  # get '/authors/:id', to: 'authors#show'
  # get '/authors', to: 'authors#index'


end
