Rails.application.routes.draw do
  namespace :backoffice do
    resources :questions
  end
end
