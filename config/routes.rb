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

  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'

  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
