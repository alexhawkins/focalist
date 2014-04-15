Focalist::Application.routes.draw do
 
 resources :lists
 resources :items
 root to: 'items#index'

end
