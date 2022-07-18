Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :appointments do
      get "appointment_impossible" => "appointments#appointment_impossible"
    end
    resources :employees
    resources :infections
    resources :patients do
      get :search, on: :collection
      get 'appointment_index' => 'patients#appointment_index'
    end
    resources :symptoms
    resources :treatments
    get 'item' => 'homes#item'
    get 'visit_date' => 'appointments#visit_date'
    get "appointment_request_index" => "appointments#request_index"
  end

  devise_scope :admin do
    root to: "admin/sessions#new"
    get 'top', to: 'admin/homes#top'
  end


  get "appointment_day_index" => "public/appointments#day_index"
  get "public/top" => "public/homes#top"
  get "about" => "public/homes#about"

  namespace :public do
    resources :appointments
    resources :patients
  end

    
  # scope :public do
  #   resources :appointments

  #   # public/appointments
  # end

  # scope module: :public do
  #   resources :appointments
  #   # appointments
  # end


end
