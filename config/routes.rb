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

  get ':username', to: 'profiles#show', as: :profile

  # Avatar routes
  get 'avatar/:size/:background/:text' => Dragonfly.app.endpoint { |params, app|
    app.generate(:initial_avatar, URI.unescape(params[:text]), { size: params[:size], background_color: params[:background] })
  }, as: :avatar

end
