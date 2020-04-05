Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "cards#top"
  resources :cards,except: [:new] do
    resources :episodes,except: [:index,:new]
  end
  get 'newcamera' ,to: 'cards#newcamera'
  get 'newfile' ,to: 'cards#newfile'
  post 'createajax' ,to: 'cards#createajax'
  post 'createdata' ,to: 'cards#createdata'
  get 'searchcamera' ,to: 'cards#searchcamera#'
  post 'searchajax' ,to: 'cards#searchajax'
end
