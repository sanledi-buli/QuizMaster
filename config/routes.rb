Rails.application.routes.draw do
  root :to => 'quizzes#index'
  namespace :backoffice do
    resources :questions
  end

  get "/quizzes", to: "quizzes#index"
  post "/quizzes/:id", to: "quizzes#create"
end
