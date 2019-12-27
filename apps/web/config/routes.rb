root to: 'users#new'

resources :users, only: %i[new create]
