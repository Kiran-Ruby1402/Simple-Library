Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  authenticated :user do
	root as: :home, :to => "borrows#index"
  end

  unauthenticated do
   root :to => redirect("/users/sign_in")
  end

  resources :categories, only: [:index] do
  	member do 
    		resources :books, only: [:index] 
    	end
  end

  resources :books, except: [:edit, :create, :update, :destroy, :new, :show] do
    collection do 
      get :name_filter
    end
  end

  scope '/categories' do
    resources :books, only: [:index] 
  end


  scope '/user' do
	  resources :book, only: [:index] do
	  	member do 
	  		resources :borrows, except: [:index]
	  	end
	  end
  end

	# resources :users, skip: [ :sessions, :registrations, :passwords ] do
	  
	# end
  
 end
