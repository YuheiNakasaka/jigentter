Rails.application.routes.draw do
  devise_for :users, skip: [:passwords, :registrations, :sessions], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  as :user do
    get "/sign_in" => "devise/sessions#new", :as => :new_user_session
    post "/sign_in" => "devise/sessions#create", :as => :user_session
    delete "/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  post "/tweets" => "tweets#create", :as => :tweets
  root to: "home#index"
  unless Rails.env.production?
    mount Resque::Server, :at => "/resque"
  end
end
