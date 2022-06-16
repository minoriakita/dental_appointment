Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :appointments
    resources :employees
    resources :infections
    resources :patients do
      get :search, on: :collection
    end
    resources :symptoms
    resources :treatments
    get 'item' => 'homes#item'
    #get 'search' => 'patients#search'
    get 'visit_date' => 'appointments#visit_date'
  end

  devise_scope :admin do
    root to: "admin/sessions#new"
    get 'top', to: 'admin/homes#top'
  end


end
