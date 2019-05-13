Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :books  do
    resources :reviews, only:[:new, :create, :destroy]
  end

  resources :authors, only:[:index, :show, :destroy]

  resources :users, only:[:show]

end
