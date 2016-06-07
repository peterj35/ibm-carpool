Rails.application.routes.draw do
	resources :computers
  root                            'static_pages#home'
  get     'about'             =>  'static_pages#about'
  get     'contact'           =>  'static_pages#contact'
  get     'signup'            =>  'users#new'
  get     'login'             =>  'sessions#new'
  post    'login'             =>  'sessions#create'
  delete  'logout'            =>  'sessions#destroy'
  #get     'add_location'      =>  'locations#new' -> use locations/new instead
  get     'manage_locations'  =>  'locations#manage'
  resources :users
  resources :locations
  resources :offers
	resources :account_activations, only: [:edit]
	resources	:password_resets,			only: [:new, :create, :edit, :update]

  # get 'locations/new'

  # get 'password_resets/new'

  # get 'password_resets/edit'

  # get 'sessions/new'

  # get 'users/new'
end
