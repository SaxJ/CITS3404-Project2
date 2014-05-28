Rails.application.routes.draw do
  resources :workspaces

  devise_for :users
  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get '/index' => 'home#index'
  get '/about' => 'home#about'
  get '/sitemap' => 'home#sitemap'
  get '/login' => 'accounts#sign_in'
  get '/loggedin' => 'accounts#signed_in'
  get '/signup' => 'accounts#register'
  get '/logout' => 'accounts#sign_out'
  get '/app' => 'workspaces#index'

  resources :workspaces do
    resources :lists
  end

  resources :lists do
    resources :items
  end

  post 'workspaces/:id/adduser' => 'workspaces#adduser'
  delete 'workspaces/:w_id/lists/:l_id/items/:id/removeme' => 'items#removeme'
  post 'workspaces/:w_id/lists/:l_id/items/:id/addme' => 'items#addme'
  post 'workspaces/:w_id/items/:id/toggledone' => 'items#toggledone'
  delete 'users/:u_id/workspaces/:w_id/removeuser' => 'workspaces#removeuser'
  delete 'workspaces/:w_id/:u_id/removeworkspace' => 'workspaces#removeworkspace'
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
