Timetrack::Application.routes.draw do



  resources :clients do
    resources :projects do
      resources :timesheets do
        resources :tasks
      end
    end
  end

  resources :permissions
  resources :roles
  get   "roles_permissions/:id" => "roles#set_permissions", as: "set_permissions"
  patch "/roles/:id" => "roles#update_permissions"
  put   "/roles/:id" => "roles#update_permissions"
  
  get "client_users/:id" => "clients#setup_client", as: "setup_client"
  
  get "consultants_project/:id" => "projects#assign_consultant", as: "assign_consultant"

  devise_for :users, :controllers => {:registrations =>"users/registrations", :passwords => "users/passwords", :users => "/users"}
  devise_scope :user do
    get   "/users" => "users#index", as: "users"
    get   "/users/edit/:id" => "users#edit", as: "edit_user"
    patch "/users/:id" => "users#update"
    put   "/users/:id" => "users#update"
    get   "/users/new" => "users#new", as: "new_user"
    post  "/users/create" => "users#create"
  end

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
  root :to => 'dashboard#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
