Segment::Engine.routes.draw do
  resources :tables, only: :create
end
