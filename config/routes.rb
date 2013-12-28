Songs::Application.routes.draw do
  root 'main#index'
  get 'apply', to: 'account#apply', as: :apply
  post 'apply', to: 'account#apply'
end
