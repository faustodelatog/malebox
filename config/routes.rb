Rails.application.routes.draw do

  get 'categorias' => 'lista_categorias#index', :as => 'lista_categorias'

  get 'pedidos' => 'pedidos_usuario#index', :as => 'pedidos_usuario'
  get 'pedidos/:id' => 'pedidos_usuario#show', :as => 'pedido_usuario'

  get 'checkout' => 'checkout#index'
  get 'checkout/confirmacion'
  post 'checkout' => 'checkout#purchase'
  post '/checkout/paypal' => 'checkout#confirm_paypal', :as => 'confirm_paypal'

  post '/inventario_cosas/addRemove' => 'inventario_cosas#add_remove', :as => 'add_remove_cosas'

  scope "/admin" do
    resources :tapas
    resources :pedidos
    resources :empaques
    resources :inventario_cosa_registros
    resources :inventario_cosas
    resources :producto_cosas
    resources :cosas

    get 'inventario_productos' => 'inventario_productos#index', :as => 'inventario_productos'
    get 'inventario_productos/:id' => 'inventario_productos#show', :as => 'inventario_producto'
    post 'inventario_productos/:id' => 'inventario_productos#update', :as => 'update_inventario_producto'
  end

  scope "/admin" do
    resources :categoria_productos
  end

  scope "/admin" do
    resources :categoria
  end

  scope "/admin" do
    resources :fotos
  end

  devise_for :usuarios, controllers: { registrations: "registrations/registrations" }
  scope "/admin" do
    resources :usuarios
  end

  get 'productos' => 'productos#index'
  get 'productos/:id' => 'productos#show', :as => 'producto'

  get 'admin' => 'admin#index'
  namespace :admin do |admin|
    resources :productos
  end
  
  root 'page#home'  

  get 'page/home'

  get 'page/contactos'

  get 'page/comocomprar'

  get 'page/politicas'

  post 'page/contactos' => 'page#send_email'

  get 'cart' => 'cart#index'
  post 'cart' => 'cart#checkout'
  get '/add_to_cart/:product_id' => 'cart#add_to_cart', :as => 'add_to_cart'
  post '/remove_from_cart/:product_id' => 'cart#remove_from_cart', :as => 'remove_from_cart'
  post '/remove_all_from_cart/:product_id' => 'cart#remove_all_from_cart', :as => 'remove_all_from_cart'

  get 'city' => 'city#index'
  post 'city' => 'city#select'

  post 'tapa_personalizada' => 'cart#add_tapa_personalizada', :as => 'add_tapa_personalizada'

  post '/armar_pedido/:id' => 'pedidos#armar', :as => 'armar_pedido'
  post '/entregar_pedido/:id' => 'pedidos#entregar', :as => 'entregar_pedido'
  post '/cancelar_pedido/:id' => 'pedidos#cancelar', :as => 'cancelar_pedido'
  post '/pagar_pedido/:id' => 'pedidos#pagar', :as => 'pagar_pedido'

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
