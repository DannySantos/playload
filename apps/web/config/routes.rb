# frozen_string_literal: true

root to: 'users#new'

resources :users, only: %i[new create]
