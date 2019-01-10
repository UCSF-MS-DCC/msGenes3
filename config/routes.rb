Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  get '/team', to: 'home#team', as: 'team'
  get '/research', to: 'home#research', as: 'research'
  get '/publications', to: 'home#publications', as: 'publications'
  get '/jobs', to: 'home#jobs', as: 'jobs'
  get '/redcap', to: 'home#redcap', as: 'redcap'
  get '*path', to: 'error#error_404', via: :all, as: 'error'
end
