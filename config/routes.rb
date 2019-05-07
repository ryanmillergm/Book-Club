Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/books', to: 'books#index'
  get '/books/show', to: 'books#show'
  get '/authors', to: 'authors#index'
end
