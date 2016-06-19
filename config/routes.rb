Rails.application.routes.draw do
  root :to => 'quizzes#index'
  namespace :backoffice do
    put '/questions/:id', to: 'questions#update'
    resources :questions, except: [:show,:update]
  end

  get "/quizzes", to: "quizzes#index"
  post "/quizzes/:id", to: "quizzes#create"
end
