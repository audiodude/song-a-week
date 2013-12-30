Songs::Application.routes.draw do
  root 'main#index'
  get 'apply', to: 'account#apply', as: :apply
  post 'apply', to: 'account#apply'
  get 'login', to: 'account#login', as: :login
  post 'login', to: 'account#login'
  get 'forgot-password', to: 'account#forgot', as: :forgot
  get 'sign_out', to: 'account#sign_out', as: :sign_out

  resources :users, only: [] do
    get :moderate, on: :collection
  end
end
