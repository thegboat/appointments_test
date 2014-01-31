Appointments::Application.routes.draw do
  namespace :v1 do
    resources :appointments
  end
end
