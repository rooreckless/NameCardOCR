Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
}
  devise_scope :user do
    get '/users/sign_out',to: 'devise/sessions#destroy'
  end
  resources :group,except: [:index] do
    collection do
      post 'belonggroup'
      
    end
    member do
      post 'resigngroup'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "cards#top"
  resources :cards,except: [:new] do
    resources :episodes,except: [:index,:new]
    collection do
      get 'newcamera'
      # get 'newcamera' ,to: 'cards#newcamera'
      # あとでこのルーティング部分はto:以下の表記がなしでいいようにしましょう。
      get 'newfile' ,to: 'cards#newfile'
      post 'createajax' ,to: 'cards#createajax'
      post 'createdata' ,to: 'cards#createdata'
      get 'searchcamera' ,to: 'cards#searchcamera'
      post 'searchajax' ,to: 'cards#searchajax'
      get 'searchnormalform' ,to: 'cards#searchnormalform'
      post 'searchnormaltext',to: 'cards#searchnormaltext'
      post 'searchcompany',to:'cards#searchcompany'
    end
  end
  
end
