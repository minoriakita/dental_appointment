Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
  root to: "homes#top"
  resources :appointments
  resources :employees
  resources :infections
  resources :patients
  resources :symptoms
  resources :treatments
end

  #root to: "admin/sessions#new"

end
