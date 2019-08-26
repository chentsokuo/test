Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :candidates do
    member do 
      # put :vote, to: 'candidate#vote'
      put :vote   #put /candidate/2/vote
    end
  end

  get '/index', to: 'candidates#index'

  root 'candidates#index'


end