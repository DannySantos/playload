# frozen_string_literal: true

root to: 'users#new'

resources :users, only: %i[new create]
resources :sessions, only: %i[new create]

delete 'sessions', as: 'logout'
