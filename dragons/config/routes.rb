Dragons::Application.routes.draw do
  resources :dragons

  resources :dragon_rental_requests do
    member do
      put 'approve'
      put 'deny'
    end
  end
  resource :session, only: [:create, :new, :destroy]
  resources :users
end
