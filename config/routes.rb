# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :reports, only: %i[index show create destroy]
    resources :incident_types, only: %i[index show create destroy update]
    resources :incident_severities
  end
end
