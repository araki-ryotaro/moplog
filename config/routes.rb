Rails.application.routes.draw do
  root to: "public/homes#top"

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    resources :posts, only: [:index, :new, :create, :show, :edit, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :genres, only: [:show]
  end

  get '/users/searches/about', to: "public/searches#top" , as: "search"

  get '/users/:id/unsubscribe' => 'public/users#unsubscribe', as: 'unsubscribe'

  patch '/users/:id/withdrawal' => 'public/users#withdrawal', as: 'withdrawal'

  devise_scope :user do
    post '/users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :posts, only: [:index, :show, :edit, :destroy, :update] do
      resources :post_comments, only: [:destroy]
    end
    resources :genres, only: [:index, :show, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
  end

  get '/admin/users/searches/about', to: "admin/searches#top" , as: "admin/search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
