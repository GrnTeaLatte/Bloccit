Rails.application.routes.draw do
  get 'rails/generate'

  get 'rails/controller'

  get 'rails/SponsoredPosts'


  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
