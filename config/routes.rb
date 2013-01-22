Driveat::Application.routes.draw do

  # Log and register 
  
  get "log_in" => "sessions#log", :as => "log_in"
  post "connect" => "sessions#create", :as => "connect"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "sessions#new", :as => "sign_up"
  post "register" => "sessions#register", :as => "register"

  #account
   get "/Account/" => "users#index", :as => "account_page"
   put "updateaccount" => "users#update", :as => "updateaccount"
   get "/account/:username" => "users#show", :as => "account_show_page"
   
   
   
   #dish
   get "/dish/edit/:id" => "dishes#edit", :as => "dish_edit_page"
   delete "/deletedish" => "dishes#destroy", :as => "deletedish"
   get "/dish/add" => "dishes#new", :as => "dish_add_page"
   post "postdish" => "dishes#create", :as => "postdish"
   get "/dish/:id" => "dishes#show", :as => "dish_show_page"
   
   #Search
   get "/list/" => "locations#index", :as => "location_search"
   
  
  #Reservation
  post "postreservation" => "reservations#reserve", :as =>"postreservation"
  post "reservation_decline" => "reservations#decline", :as => "reservation_decline"
  post "reservation_cancel" => "reservations#cancel", :as => "reservation_cancel"
  post "reservation_reconsider" => "reservations#reconsider", :as => "reservation_reconsider"
  post "reservation_approve" => "reservations#approve", :as => "reservation_approve"
  post "reservation_checkout" => "reservations#checkout", :as => "reservation_checkout"
    
  root :to => "home#index"
  
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
  # root :to => 'users#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
