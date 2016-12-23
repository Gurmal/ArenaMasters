Rails.application.routes.draw do
  get 'fights/show'

  get 'events/:id/buildSchedule', to: 'events#buildSchedule', as: 'buildSchedule'
  get 'fights/:id/run', to: 'fights#run', as: 'run_fight'
  get 'teams/:id/backfill', to: 'teams#backfill', as: 'backfill'

  resources :events do
  	resources :fights, only: [:show]
  end
  resources :teams do
  	resources :gladiators
  end

  root 'teams#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
