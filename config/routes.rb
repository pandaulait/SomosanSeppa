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
    get 'selection_quizzes/random_select', to: 'selection_quizzes#random_select'
    get 'selection_quizzes/seppa', to: 'selection_quizzes#seppa'
    patch 'selection_quiz_image_destroy/:id' => 'selection_quizzes#image_desttroy', as: 'selection_quiz_image_destroy'
    resources :selection_quizzes do
      resources :results, only: %i[create show]
      # get '/answer' => 'results#answer', as: 'answer'
      resources :choices, only: %i[new destroy create]
    end
    patch 'descriptive_quiz_image_destroy/:id' => 'descriptive_quizzes#image_desttroy',
          as: 'descriptive_quiz_image_destroy'
    resources :descriptive_quizzes do
      resources :results, only: %i[create show]
    end

    get 'today_quizzes/somosan', to: 'today_quizzes#somosan'
    get 'today_quizzes/seppa' => 'today_quizzes#seppa'
    resources :today_quizzes, only: [:index]
    resources :today_results, only: %i[create index]
    root to: 'homes#top'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'

    resources :chat_rooms, only: %i[index create]
    resources :chats, only: %i[create]
    resources :activities, only: %i[index]
    get 'activities/read', to: 'activities#read'
  end

  namespace :admin do
    resources :selection_quizzes, only: %i[show update index show]
    resources :categories, only: %i[index create destroy]
    resources :users, only: %i[index update]
    resources :chat_rooms, only: %i[index show] do
      resources :chats, only: %i[create]
    end
  end
end
