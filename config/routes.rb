Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'posts#index'

  resources :posts

  # Avatar routes
  get 'avatar/:size/:background/:text' => Dragonfly.app.endpoint { |params, app|
    app.generate(:initial_avatar, URI.unescape(params[:text]), { size: params[:size], background_color: params[:background] })
  }, as: :avatar

end
