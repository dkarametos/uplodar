Uplodar::Engine.routes.draw do

  resources :share_assignments

  resources :events
  resources :shares
  resources :permissions, :controller => 'users' do 
    resources :shares, :controller => 'share_assignments'
  end

  match '/browser/'                           => 'browser#create', :as => :browser_create, :via => :post
  match '/browser/edit/:share(/*path)/:entry' => 'browser#edit',   :as => :browser_edit,   :via => :get,    :constraints => {:entry => /.*/}
  match '/browser/update'                     => 'browser#update', :as => :browser_update, :via => :post
  match '/browser/:share(/*path)/:entry'      => 'browser#delete', :as => :browser_delete, :via => :delete, :constraints => {:entry => /.*/}
  match '/browser/:share(/*path)'             => 'browser#index',  :as => :browser,        :via => :get

  root :to => 'home#index'
end
