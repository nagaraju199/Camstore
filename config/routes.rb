Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  devise_for :users, controllers: { sessions: 'users/sessions' , registrations: 'users/registrations'  }
  post 'authenticate', to: 'authentication#authenticate'
  # get 'authenticate', to: 'authentication#authenticate'

  namespace :api do
    namespace  :v1 do
      resources :products
      post 'get_cart_for_user', to: "products#get_cart_for_user"
      post 'add_product_to_cart', to: "products#add_product_to_cart"
      post 'create_cart', to: "products#create_cart"
      delete 'remove_product_to_cart', to: "products#remove_product_to_cart"
      post 'login', to: "home#login"
    end
  end

end
