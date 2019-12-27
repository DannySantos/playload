root to: 'users#new'

resources :users, only: [:new, :create]
