Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'


  # resources :books  do
  #   resources :reviews, only:[:new, :create, :destroy]
  # end

  get '/books', to: 'books#index'
  post '/books', to: 'books#create'
  get '/books/new', to: 'books#new', as: :new_book
  get '/books/:id/edit', to: 'book#edit', as: :edit_book
  get '/books/:id', to: 'books#show', as: :book
  patch '/books/:id', to: 'books#update'
  put '/books/:id', to: 'books#update'
  delete '/books/:id', to: 'books#destroy'

  post 'books/:book_id/reviews', to: 'reviews#create', as: :book_reviews
  get '/books/:book_id/reviews/new', to: 'reviews#new', as: :new_book_review
  delete '/books/:book_id/reviews/:id', to: 'reviews#destroy', as: :book_review




  # resources :authors, only:[:index, :show, :destroy]
  get '/authors', to: 'authors#index'
  get '/authors/:id', to: 'authors#show', as: :author
  delete '/authors/:id', to: 'authors#destroy'

  # resources :users, only:[:show]
  get '/users/:id', to: 'users#show', as: :user

end
