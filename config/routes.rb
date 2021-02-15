Rails.application.routes.draw do


  devise_for :employees, controllers: {
    sessions: 'employees/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :companies, only: [:index, :show] do
    # resources :jobs, only: [:index] do
    #   collection do
    #     get 'company_jobs'
    #   end
    # end
    member do
      get 'company_jobs'
    end
  end
  # resources :jobs
  resources :employee, only:[:index]
end
