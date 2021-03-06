Rails.application.routes.draw do

  root 'users#index'
  resources :users, only: [:new, :create]
  resources :teams, except: [:edit, :destroy]
  get 'sign_in', to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  delete '/sign_out', to: "sessions#destroy", as: "sign_out"
  namespace :team_captain do
    resources :teams, only: [:show, :update]
    patch 'teams/:id/:user_id', to: "teams#remove_user_from_team", as: "remove_user"
    resources :games, only: [:index, :show, :new, :create]
    patch 'games/:id', to: 'games#join_game', as: "join_game"
  end
  namespace :player do
    get 'move', to: 'moves#edit'
    patch 'move', to: 'moves#update'
    get 'target/:move_choice', to: 'games#target_team_users', as: 'target' 
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
