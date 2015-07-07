Tsai::Application.routes.draw do

  resources :contactus

  resources :user_belongs

  resources :order_by_products

  resources :product_orders

  resources :members

  resources :order_states

  resources :in_out_types

  resources :product_verify_contents

  resources :product_verify_states

  resources :product_in_outs

  resources :verify_type_mains

  mount Ckeditor::Engine => '/ckeditor'
  resources :product_verify_types

  resources :product_verifies

  resources :products

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

  get 'box', :to => "pact#box"


  get 'excel', :to => "users#excel"

  get 'login', :to => "login#login_form"
  get 'logout', :to => "login#logout"
  get 'forget_pas', :to => "login#forget_pas"

  get 'in_list', :to => "product_in_outs#in_list"
  get 'out_list', :to => "product_in_outs#out_list"
  get 'store_list', :to => "products#store_list"

  get 'advance_pas', :to => "login#advance_pas"

  get '/product_in_outs/in_come/destroy(/:id)', :to => "product_in_outs#in_come_destroy"
  get '/product_in_outs/out_come/destroy(/:id)', :to => "product_in_outs#out_come_destroy"

  post 'do_forget_pas' , :to => "login#do_forget_pas"
  post 'do_login' , :to => "login#do_login"
  post 'do_advance_pas' , :to => "login#do_advance_pas"


  post 'p_good_or_not'  , :to=> "pact#p_good_or_not"
  post 'post_order_data'  , :to=> "pact#post_order_data"
  post 'get_p_in_out_serial'  , :to=> "pact#get_p_in_out_serial"  ##
  post 'p_store_area'  , :to=> "pact#p_store_area"
  post 'inp_save_date' , :to=> "pact#inp_save_date"
  post 'inp_save_num' , :to=> "pact#inp_save_num"

  post 'do_in_or_out'  , :to=> "pact#do_in_or_out"
  post 'get_all_products' , :to => "pact#get_all_products"


  post 'change_product_verify_state' , :to => "pact#change_product_verify_state"

  post 'post_username' , :to => "pact#post_username"
  #ajax/post_username

  post 'check_username' , :to => "pact#check_username"
  post 'check_email' , :to => "pact#check_email"
  post 'update_order_data' , :to => "pact#update_order_data"
  post 'get_select_products' , :to => "pact#get_select_products"
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
