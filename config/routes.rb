Rails.application.routes.draw do
  devise_for :users
  resources :fight_styles
  get 'fights/show'

  get 'events/:id/buildSchedule', to: 'events#buildSchedule', as: 'buildSchedule'
  get 'events/:id/run', to: 'events#run', as: 'run_event'
  get 'fights/:id/run', to: 'fights#run', as: 'run_fight'
  get 'teams/:id/backfill', to: 'teams#backfill', as: 'backfill'
  get 'teams/backfill', to: 'teams#backfillAll', as: 'backfillAll'
  get 'teams/showInactive', to: 'teams#showInActive', as: 'showInActive'


  resources :events do
  	resources :fights, only: [:show]
  end
  resources :teams do
  	resources :gladiators
  end

  root 'teams#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
