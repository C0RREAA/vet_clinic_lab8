Rails.application.routes.draw do
  get "appointments/index"
  get "appointments/show"
  get "vets/index"
  get "vets/show"
  get "pets/index"
  get "pets/show"
  get "owners/index"
  get "owners/show"
  root "owners#index"

  resources :owners,       only: [:index, :show]
  resources :pets,         only: [:index, :show]
  resources :vets,         only: [:index, :show]
  resources :appointments, only: [:index, :show]
end