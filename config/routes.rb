Focalist::Application.routes.draw do
 
 devise_for :users
 resources :lists do 
  resources :items do
    get :complete, on: :member  # complete_list_item(@list, item)
  end
 end
 
 root to: 'lists#index'

end
