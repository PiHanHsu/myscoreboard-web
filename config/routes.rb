Rails.application.routes.draw do

  devise_for :users, :controllers => {
   :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :users do
    resources :cards
    collection do
      get :search
    end
  end
  resources :cards
  resources :games
  resources :score_records
  resources :teams do
    collection do
      post :bulk_update
    end

    member do
      post :add_player
    end
  end


  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do

    post "/login" => "auth#login"
    post "/logout" => "auth#logout"
    post "/signup" => "auth#signup"
    post "reset_password" => "users#reset_password"

    resources :users do
    collection do
      get :search
    end

    end
    resources :teams
    resources :games do
      collection do
        get :stats
      end
    end
  end


  get 'enteruserid' => 'enteruserids#index'
  patch 'enteruserid' => 'enteruserids#update'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'games#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
