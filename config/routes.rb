Rails.application.routes.draw do


  devise_for :candidates, path: 'candidates'
  devise_for :employees, path: 'employees'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :companies, only: [:index, :show, :new] do
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
  resources :employees, only:[:index]
  resources :jobs , only:[:index, :new, :create, :show, :edit, :update] do
    member do
      get 'apply'
    end
  end

  resources :candidates, only:[] do
    member do
      get 'candidate_jobs'
      # get 'candidate_jobs/:job_id', to: 'candidates#job_applied', as: 'job_applied'
    end
    resources :jobs, only:[] do
      member do
      get 'job_applied'
      end
    end
  end
end
