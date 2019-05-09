Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'


  # get '/books', to: 'books#index'
  # get '/books/show', to: 'books#show'
  # get '/authors', to: 'authors#index'
  # get '/authors/show', to: 'authors#show'
  # get '/authors', to: 'authors#index'

  resources :books, only:[:index, :show, :new] do
    resources :reviews, only:[:new, :create]
  end

  resources :authors, only:[:index, :show]


end
