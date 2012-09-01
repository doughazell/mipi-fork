V01::Application.routes.draw do
  resources :subscriptions

#  resources :data_sheets 

  resources :data_element_collections

  resources :globes do

    resources :presentations
    
    resources :data_elements do
      post 'new(/:action)'
      resources :fields do
        member do 
          get 'link'
          put 'subscribe'
        end
        
        resources :target_globe do
          member do
            get 'link'
          end
        end
      end
    end    

#    resources :name_data_elements
    
    member do
      get 'preview'
    end
    
    resources :profiles do
      
      collection do
        post 'sort'
      end
      
      member do
        get 'preview'
      end
      
      resources :data_sheets do
        
        member do
          get 'draw'
          get 'preview'
          post 'change'
       end
        
        collection do
#          put 'change'
        end
        
#        resources :data_elements do
# 
#          resources :fields
##          collection do
##            get 'change'
##          end
#          
#        end
#        
      end
      
    end
    
  end

  match 'javascripts/dynamic_data_elements', :to => 'javascripts#dynamic_data_elements'

  devise_for :users
  
  require 'subdomain'
  constraints(Subdomain) do
    match '/' => 'globes#show'
  end

  match 'home/problem' => 'home#problem'
  match 'home/solution' => 'home#solution'
  match 'home/indsignup' => 'registers#new'
  match 'home/orgsignup' => 'registers#new'
  match 'home/aboutus' => 'home#aboutus'

  match 'extract/json/*data_element_type/*data_element_name' => 'data_elements#extract', defaults: {format: 'json'}
  match 'extract_all/json/*data_element_type' => 'data_elements#extract_all', defaults: {format: 'json'}
  match 'extract/text/*data_element_type/*data_element_name' => 'data_elements#extract', defaults: {format: 'txt'}
  match 'extract_all/text/*data_element_type' => 'data_elements#extract_all', defaults: {format: 'txt'}
  match 'extract/txt/*data_element_type/*data_element_name' => 'data_elements#extract', defaults: {format: 'txt'}
  match 'extract_all/txt/*data_element_type' => 'data_elements#extract_all', defaults: {format: 'txt'}

  match 'extract/*data_element_type/*data_element_name' => 'data_elements#extract', defaults: {format: 'xml'}
  match 'extract_all/*data_element_type' => 'data_elements#extract_all', defaults: {format: 'xml'}

#  match '/' => 'globes#show', :constraints => { :subdomain => /.+/ }
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
#match 'data_sheets/:render2' => 'data_sheet#render2'

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
#root :to => "globes#index"
root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
