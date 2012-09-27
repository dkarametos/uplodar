Uplodar::Engine.routes.draw do

  resources :events

  resources :shares do
    resources :users, :controller => 'assignments', :only => :index
  end

  resources :users, :only => :index do
    resources :shares, :controller => 'assignments', :only => [:index, :show, :update] do
      collection do
        get :assignments
        put :assign
      end
    end
  end

  match '/browser/'                           => 'browser#create', :as => :browser_create, :via => :post
  match '/browser/edit/:share(/*path)/:entry' => 'browser#edit',   :as => :browser_edit,   :via => :get,    :constraints => {:entry => /.*/}
  match '/browser/update'                     => 'browser#update', :as => :browser_update, :via => :post
  match '/browser/:share(/*path)/:entry'      => 'browser#delete', :as => :browser_delete, :via => :delete, :constraints => {:entry => /.*/}
  match '/browser/:share(/*path)'             => 'browser#index',  :as => :browser,        :via => :get

  root :to => 'home#index'
end
