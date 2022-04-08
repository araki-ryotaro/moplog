Rails.application.routes.draw do
  root to: "public/homes#top"

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    resources :posts, only: [:index, :new, :create, :show, :edit, :destroy, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end

  get '/users/:id/unsubscribe' => 'public/users#unsubscribe', as: 'unsubscribe'

  patch '/users/:id/withdrawal' => 'public/users#withdrawal', as: 'withdrawal'

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :posts, only: [:index, :show, :edit, :destroy, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end

  get '/admin/users/:id/unsubscribe' => 'admin/users#unsubscribe', as: 'admin_unsubscribe'

  patch '/admin/users/:id/withdrawal' => 'admin/users#withdrawal', as: 'admin_withdrawal'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
