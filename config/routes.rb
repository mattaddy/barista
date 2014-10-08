Rails.application.routes.draw do
  root to: 'pages#one'

  get '/pages/one', to: 'pages#one'
  get '/pages/two', to: 'pages#two'
end
