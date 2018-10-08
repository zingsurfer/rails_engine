Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/best_day', to: 'best_day#show'
        get '/:id/merchant', to: 'merchant#show'
        get '/most_items', to: 'most_items#index'
        get '/most_revenue', to: 'most_revenue#index'
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/customer', to: 'customer#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#show'
        get '/:id/transactions', to: 'transactions#index'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item', to: 'item#show'
      end

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/customers_with_pending_invoices', to: 'pending_invoices#index'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/revenue', to: 'revenue#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
      end

      namespace :transactions do
        get '/:id/invoice', to: 'invoice#show'
      end

      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
