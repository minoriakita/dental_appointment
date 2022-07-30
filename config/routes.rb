Rails.application.routes.draw do

  devise_scope :patient do
    get 'patients/sign_up' => 'public/registrations#new'
    post 'patients/sign_up' => 'public/registrations#create', as: 'patient_registration'
  end

  devise_for :patients, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }

  devise_for :admins, skip: [:registrations] ,controllers: {
    sessions: "admin/sessions",
    passwords: 'admin/passwords'
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
    get 'visit_date/:id' => 'appointments#visit_date', as: 'visit_date'
    get "appointment_request_index" => "appointments#request_index"
  end

  #ルートページにしている
  # devise_scope :admin do
  #   root to: "admin/sessions#new"
  #   get 'top', to: 'admin/homes#top'
  # end
  root to: "public/homes#about"
  get 'admin/top', to: 'admin/homes#top'
  get "public/top", to: "public/homes#top"
  get "appointment_day_index" => "public/appointments#day_index"
  get "about" => "public/homes#about"

  namespace :public do
    resources :appointments, except: :index do
      member do
        get :history
      end
    end

    resources :patients
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
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
