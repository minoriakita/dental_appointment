Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :appointments do
      get "appointment_request" => "appointments#appointment_request"
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
    get "appointment_request" => "appointments#appointment_request"
  end

  devise_scope :admin do
    root to: "admin/sessions#new"
    get 'top', to: 'admin/homes#top'
  end

  namespace :public do
    resources :appointments
    resources :patients do
      get "appointment_index" => "patients#appointment_index"
    end
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
