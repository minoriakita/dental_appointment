Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :appointments
    resources :employees
    resources :infections
    resources :patients
    resources :symptoms
    resources :treatments
  end
  devise_scope :admin do
    root to: "admin/sessions#new"
    get 'top', to: 'admin/homes#top'
  end
end
