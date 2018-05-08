Rails.application.routes.draw do
  resources :customers
  mount Segment::Engine => "/segment"
end
