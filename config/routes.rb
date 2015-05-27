Tsai::Application.routes.draw do

  resources :accesses
  resources :msgs
  resources :roles
  resources :id_seqs
  resources :store_areas
  resources :trades
  resources :users

  get "dashboard/index"
  root "dashboard#index"

  # get 'cc', :to => "users#cc"

  get 'login', :to => "login#login_form"
  get 'logout', :to => "login#logout"
  get 'forget_pas', :to => "login#forget_pas"
  get 'advance_pas', :to => "login#advance_pas"

  post 'do_forget_pas' , :to => "login#do_forget_pas"
  post 'do_login' , :to => "login#do_login"
  post 'do_advance_pas' , :to => "login#do_advance_pas"

  post 'post_username' , :to => "pact#post_username"
  #ajax/post_username

  post 'check_username' , :to => "pact#check_username"
  post 'check_email' , :to => "pact#check_email"


  #get "demo/index"
  match ':controller(/:action(/:id))', :via => [:get, :post]
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
