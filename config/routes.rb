Rails.application.routes.draw do

  root to: 'assignments#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :students, controllers: {
    registrations: 'students/registrations',
    sessions: 'students/sessions'
  }

  resources :assignments, only: [:index, :show] do
    resources :ranks, only: [:index, :new, :create] 
  end
end
