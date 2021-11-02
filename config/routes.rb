# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'public/devise/sessions',
    registrations: 'public/devise/registrations'
  }
  # devise_scope :user do
  #   get '/users', to: 'devise/registrations#new'
  # end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # devise_for :admins,
  # path: :admin,
  # controllers: {
  #   sessions: 'admin/devise/sessions',
  #   registrations: 'admin/devise/registrations'
  # }

  scope module: :public do
    resources :users, only: %i[show edit update] do
      resources :results, only: [:index]
    end
    get 'quizzes/random_select', to: 'quizzes#random_select'
    get 'quizzes/seppa', to: 'quizzes#seppa'
    resources :quizzes do
      resources :results, only: %i[create show]
      # get '/answer' => 'results#answer', as: 'answer'
      resources :choices, only: %i[new destroy create]
    end

    get 'today_quizzes/somosan', to: 'today_quizzes#somosan'
    get 'today_quizzes/seppa' => 'today_quizzes#seppa'
    resources :today_quizzes, only: [:index]
    resources :today_results, only: %i[create index]
    root to: 'homes#top'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  end

  namespace :admin do
    resources :quizzes, only: %i[show update index show]
    resources :categories, only: %i[index create destroy]
    resources :users, only: %i[index update]
  end
end
