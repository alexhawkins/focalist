Focalist::Application.routes.draw do
 
 devise_for :users
 resources :lists do 
  resources :items do
    #get :complete, on: :member  # complete_list_item(@list, item)
   get '/complete' => 'votes#complete', as: :complete
   get '/incomplete' => 'votes#incomplete', as: :incomplete
  end
 end
 
 root to: 'lists#index'

end
