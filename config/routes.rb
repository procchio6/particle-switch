Rails.application.routes.draw do
  root 'application#home'
  post 'toggle' => 'application#toggle'
end
