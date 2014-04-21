Focalist::Application.routes.draw do
 
 devise_for :users
 resources :lists do 
  get '/show_list' => 'lists#show_list', as: :show_list
  get '/hide_list' => 'lists#hide_list', as: :hide_list
  resources :items, except: [:index] do
   #create routes for complete and incomplete which will allow us to toggle
   #the boolean state of our complete database attribute.
   get '/complete' => 'items#complete', as: :complete
   get '/incomplete' => 'items#incomplete', as: :incomplete
   #needed for sort method in item Controller
   collection { post :sort }
  end
 end
 
 root to: 'lists#index'

end
