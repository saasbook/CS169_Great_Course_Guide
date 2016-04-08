Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'login#index'

  # General
  get "/logout" => "application#logout"
  get "/welcome" => "application#welcome"
  get "/user" => "application#index"
  get "/edit" => "application#edit"
  post "/update" => "application#update"
  post "/create" => 'application#create'  
  get '/users/emails' => 'application#emails'

  # Professors
  resources :professors, only: [:index, :show]
  get '/distinguished' => 'professors#dist'

  # Courses
  resources :courses, only: [:index, :show]
  get '/courses/all' => 'courses#all'
end
