Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'posts#index'

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

  get   ':username', to: 'profiles#show', as: :profile
  get   ':username/edit', to: 'profiles#edit', as: :edit_profile
  patch ':username/edit', to: 'profiles#update', as: :update_profile

  # Avatar routes
  get 'avatar/:background/:text' => Dragonfly.app.endpoint { |params, app|
    app.generate(:initial_avatar, URI.unescape(params[:text]), { background_color: params[:background] })
  }, as: :avatar

end
