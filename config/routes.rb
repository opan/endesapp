Rails.application.routes.draw do

  root 'home#index'

  resources :home, :only => [:index] do
    collection do
      get "modal_signup"
      get "modal_signin"
    end
  end

  resources :sistems, :only => [:index] do
    collection { post :sign_in      ,   to: "sistems#sign_in"}
    collection { post :sign_up      ,   to: "sistems#sign_up"}
    collection { get  :sign_out     ,  to: "sistems#sign_out"}
    collection { get  :encrypt_form ,  to: "sistems#encrypt_form"}
    collection { get  :decrypt_form ,  to: "sistems#decrypt_form"}
  end

  resource :m_encryptions, :only => [:index] do
    collection do
      post 'encrypt_file'
      get 'download_file'
    end
  end

  resource :m_decryptions, :only => [:index] do
    collection do
      post 'decrypt_file'
      get 'download_file'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
