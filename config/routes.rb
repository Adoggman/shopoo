Shopoo::Application.routes.draw do

  get "main/about"
  get "main/contact"

  resources :sessions, :only => [:new, :create, :destroy]
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/signup', :to => 'users#new'
  match '/profile/:id/edit', :to => 'users#edit', :as => 'edit_profile'
  match '/profile/:id', :to => 'users#show', :as => 'profile'
  match '/profile/:id/billing', :to => 'users#billing', :as => 'billing'
  put 'users/update_billing'
  match '/cart/update_quantity', :to => 'items#update_quantity', :as => 'update_quantity'
  match '/cart/add_promo', :to => 'items#add_promo', :as => 'add_promo'
  match '/checkout', :to => 'items#checkout'
  match '/finalize_checkout', :to => 'items#finalize_checkout'
  resources :users
  resources :items
  resources :promos
  match '/allpromos', :to => 'promos#browse'
  match '/new', :to => 'items#new'
  match '/browse', :to => 'items#browse'
  match '/add_item', :to => 'users#add_item'
  match '/cart', :to => 'items#cart'
  match '/remove_item', :to => 'users#remove_item'
  match '/view/:name/:id', :to => 'items#view', :as => 'view'
  root :to => 'main#home'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
