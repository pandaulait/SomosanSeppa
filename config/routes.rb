Rails.application.routes.draw do

  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions:      'public/devise/sessions',
    registrations: 'public/devise/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  devise_for :admins,
  path: :admin,
  controllers: {
    sessions: 'admin/devise/sessions',
    registrations: 'admin/devise/registrations'
  }

  scope module: :public do
    resources :users, only: [:show, :edit, :update]
    root to: 'homes#top'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  end
end
