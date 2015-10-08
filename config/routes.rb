Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'landing_pages#main'

  #For social networks authorization
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # Example of regular route:
  get '/test' => 'landing_pages#test'

  #Counters for main page
  get '/api/v1/authors/totalbloggers' => 'authors#totalbloggers'
  get '/api/v1/posts/totalarticles' => 'posts#totalarticles'
  get '/api/v1/posts/totalissues' => 'posts#totalissues'

  
  #Data for leaderboards
  get '/api/v1/authors/mediumfeaturedbloggers' => 'authors#mediumfeaturedbloggers'
  get '/api/v1/authors/grandmatop' => 'authors#grandmatop'


  #Data for blogger page

  scope 'api' do
    scope 'v1' do
      resources :authors, only: [:index, :show]
    end
  end
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
